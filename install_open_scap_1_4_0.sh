#!/bin/bash
sleep 1
echo -e '\nINFO: Skrypt instalacyjny OpenSCAP w wersji 1.4.0 zostanie za chwilę uruchomiony...'

sleep 2
echo -e '\nINFO: Proces rozpczenie się od aktualizacji pakietów w repozytoriach, a następnie zainstalowane zostaną potrzebne do działania programu zależości...\n'

sleep 4

# Update repozytoriów
apt update

# Instalacja wymaganych pakietów i zależności
apt install -y bzip2 build-essential cmake git libbz2-dev libcurl4-openssl-dev libgcrypt20-dev libglib2.0-dev libgnutls28-dev libpcap-dev libssh-dev libxml2-dev libxml2-utils libxmlsec1-dev libxslt1-dev xsltproc

echo -e '\nINFO: Zależności i potrzebne pakiety zostały zainstalowane, a usługi zrestartowane.' 
sleep 3
echo -e '\nINFO: Za chwilę rozpocznie się pobieranie plików źródłowych OpenSCAP...\n'
sleep 3

# Pobranie i rozpakowanie źródeł OpenSCAP
wget https://github.com/OpenSCAP/openscap/releases/download/1.4.0/openscap-1.4.0.tar.gz
tar -xvzf openscap-1.4.0.tar.gz
cd openscap-1.4.0

echo -e '\nINFO: Pliki źródłowe OpenSCAP pobrane i rozpakowane.'
sleep 3 
echo -e '\nINFO: Za chwilę rozpocznie się budowanie projektu, kompilacja źródeł oraz instalacja OpenSCAP...\n'
sleep 4

# Budowanie i instalacja OpenSCAP
mkdir build
cd build/
cmake ..
make
make install
ldconfig

echo -e '\nINFO: Kompilacja i instalacja OpenSCAP zakończona.' 
sleep 3
echo -e '\nINFO: Za chwilę rozpocznie się pobieranie plików źródłowych profili SSG...\n'
sleep 4

# Sklonowanie repozytorium ComplianceAsCode do katalogu głównego
cd ~
git clone https://github.com/ComplianceAsCode/content.git
cd content/build
cmake ..

echo -e '\nINFO: Profile SSG pobrane i przygotowane do konfiguracji.' 
sleep 3
echo -e '\nINFO: Za chwilę uruchomiony zostanie skrypt wyłączający z kompilacji profili SSG systemy inne niż Ubuntu 22.04...'
sleep 4

# Wyłączenie wszystkich opcji poza Ubuntu 22.04

# Ścieżka do pliku CMakeCache.txt
input_file="CMakeCache.txt"

# Sprawdzenie, czy plik CMakeCache.txt istnieje
if [[ ! -f "$input_file" ]]; then
    echo "Plik CMakeCache.txt nie został znaleziony. Upewnij się, że komenda cmake przebiegła pomyślnie."
    exit 1
fi

# Tymczasowy plik wyjściowy
temp_file=$(mktemp)

# Inicjalizacja zmiennej linii
line_number=0

# Przetwarzanie pliku linia po linii
while IFS= read -r line; do
    ((line_number++))
    if ((line_number >= 193 && line_number <= 296)) && [[ "$line" != "SSG_PRODUCT_UBUNTU2204:BOOL=ON" ]]; then
        # Zamień :BOOL=ON na :BOOL=OFF w odpowiednich liniach
        echo "${line/:BOOL=ON/:BOOL=OFF}" >> "$temp_file"
    else
        # Kopiuj linie bez zmian
        echo "$line" >> "$temp_file"
    fi
done < "$input_file"

# Zamień oryginalny plik tymczasowym
mv "$temp_file" "$input_file"

echo -e '\nINFO: Konfiguracja profili wyłączająca wszystkie inne niż te przeznaczone dla systemu Ubuntu 22.04 zakończona.' 
sleep 3
echo -e '\nINFO: Za chwilę rozpoczenie się kompilacja plików źródłowych...\n'
sleep 3

# Skompilowanie projektu
make

echo -e '\nINFO: Profile SSG skompilowane i gotowe do pracy. '
sleep 2

# Informacja o zakończeniu
echo -e "\nINFO: Zrobione. OpenSCAP w wersji 1.4.0 został poprawnie zainstalowany.\n"

sleep 1
