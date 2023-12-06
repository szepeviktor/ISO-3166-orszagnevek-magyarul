# Ország- és területnevek magyarul

Forrás: Miniszterelnökség / Földrajzinév-bizottság / Ország- és területnevek

## Listák

1. [Független államok](./names-independent.tsv)
1. [Egyéb jogállású területek](./names-other.tsv)

## Lábjegyzetek

| Ország | Lábjegyzet |
| ------ | ---------- |
| Fehéroroszország | Nemzetközi kapcsolatokban a Belarusz, Belarusz Köztársaság névalak is használható. |
| Németország | Nemzetközi kapcsolatokban a „Németországi Szövetségi Köztársaság” államnév is használható. |
| Szváziföld | Nemzetközi kapcsolatokban idegen nyelvű szövegekben az ENSZ-ben elfogadott névalak (Eswatini) használható. |
| Vatikán | Nemzetközi kapcsolatokban, illetve bizonyos célokra a „Szentszék” elnevezés is használható. |
| Tajvan | ENSZ és egyéb többoldalú kapcsolatokban a „Tajvan, Kína tartománya” magyarázattal kiegészített név is használható. |

## Feldolgozás

1.  PDF fájl letöltése
    https://cdn.kormany.hu//uploads/sheets//4/4f/4f1/4f1446d8e1badc4b778ff60861cf799.pdf
1.  Szöveg kinyerése a PDF fájlból [XpdfReader](https://www.xpdfreader.com/download.html) programmal
    ```shell
    pdftotext -raw -enc UTF-8 4f1446d8e1badc4b778ff60861cf799.pdf pdf-contents.txt
    ```
1.  Független államok kinyerése
    ```shell
    cat pdf-contents.txt | tr -d '\f' | sed -e '/^államot$/,/Egyéb jogállású területek$/ !d' >names-independent.txt
    ```
1.  Egyéb jogállású területek kinyerése
    ```shell
    cat pdf-contents.txt | tr -d '\f' | sed -e '/Egyéb jogállású területek$/,$ !d' >names-other.txt
    ```
1.  Listák sorokba igazítása
    ```shell
    ./fix-names.sh
    ```
1.  Listák ellenőrzése
    ```shell
    grep -v '^[A-Za-zÁÉÍÓÖŐÚÜŰáéíóöőúüű /-]\+ [A-Z]\{2\} [A-Z]\{3\} [0-9]\{3\}$' names-independent-fixed.txt
    grep -v '^[A-Za-zÁÉÍÓÖŐÚÜŰáéíóöőúüű ()/-]\+ [A-Z]\{2\} [A-Z]\{3\} [0-9]\{3\} > ' names-other-fixed.txt
    ```
1.  Azonosítók ellenőrzése
    ```shell
    wget https://github.com/PrinsFrank/standards/raw/main/src/Country/CountryNumeric.php
    diff <(grep -o "'[0-9]\{3\}'" <CountryNumeric.php|cut -d"'" -f2|sort) <(grep -ho '[0-9]\{3\}' names-*-fixed.txt|sort)
    ```
