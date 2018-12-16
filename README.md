#SipHash-vhdl
Projekt SipHash -> VHDL

a) zaimplementować sprzętowy koprocesor kryptograficzny wybranego algorytmu lub protokołu, przy czym:

i. należy wykonać implementację po kolei wszystkich bloków składowych koproce- sora zgodnie z przyjętym projektem;

b) opracować testy zgodnie z planem testów, przy czym:

i. należy pozyskać wzorcowe implementacje programowe algorytmu(ów) lub proto- kołów kryptograficznych. Implementacje te powinny zostać zmodyfikowane w taki sposób, aby na każdym kroku ich działania dostępne były wyniki pośrednie;

ii. dla każdego z zaimplementowanych bloków powinien zostać opracowany Test- Bench umożliwiający przetestowanie wszystkich funkcji bloku;

c) wykonać testowanie symulacyjne, przy czym: i. każdy z zaimplementowanych bloków powinien być przetestowany w zakresie wszystkich funkcji za pomocą dedykowanego pliku TestBench;

ii. testowanie powinno dowodzić spełnienia wszystkich wymagań funkcjonalnych sta- wianych koprocesorowi;

d) wykonać integrację z modułem interfejsu i testowanie, przy czym: i. projekt powinien zostać połączony z interfejsem komunikacyjnym;

ii. porty zewnętrzne interfejsu komunikacyjnego powinny zostać przypisane do od- powiednich wyjść struktury programowalnej;

iii. projekt powinien zostać skompilowany dla układu EP4CE6 dostępnego w sali laboratoryjnej;

iv. zalecane jest wykorzystanie interfejsu komunikacyjnego udostępnionego przez pro- wadzącego zajęcia w postaci projektu FPGACOMMEXAMPLE-v2;

v. układ koprocesora musi posiadać interfejs zewnętrzny zgodny z encją EXAMPLE zdefiniowaną w projekcie FPGACOMMEXAMPLE-v2; vi. w ramach realizacji zadania należy samodzielnie zaplanować przestrzeń adresową koprocesora;

vii. projektowany koprocesor musi posiadać rejestr statusu mówiący o stanie kopro- cesora;

viii. w ramach realizacji zadania należy samodzielnie zaplanować postać rejestru sta- tusu;

ix. testowanie powinno umożliwiać sprawdzenie wszystkich funkcji koprocesora pod- czas pracy w rzeczywistej strukturze programowalnej;

x. do struktury programowalnej będzie podłączony moduł SerialToUsb oparty o układ CH340 w następujący sposób:

pin układu CH340 pin struktury programowalnej CH340_TX PIN_80 CH340_RX PIN_84

xi. od strony komputera PC moduł obsługiwany jest przez terminal (np. PUTTY); xii. interfejs komunikacyjny akceptuje dwa polecenia:

A. w xxxxxxxx yyyyyyyy - gdzie w oznacza zapis danych yyyyyyyy do koproce- sora pod adres xxxxxxxx;

B. r xxxxxxxx - gdzie r oznacza odczyt danych z koprocesora spod adresu xxxxxxxx; xiii. interfejs komunikacyjny zwraca dwa statusy: done (w przypadku pomyślnego wykonania polecenia), error (w przypadku błędu); xiv. terminal do poprawnej pracy powinien mieć ustawione następujące opcje: A. właściwy numer portu COM B. prędkość 115200 bps C. Terminal: Implicit LF with every CR

xv. w celu zapoznania się z interfejsem komunikacyjnym należy przeanalizować pro- jekt FPGACOMMEXAMPLE-v2;
