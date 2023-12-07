# Ország- és területnevek magyarul

Forrás: Miniszterelnökség / Földrajzinév-bizottság / Ország- és területnevek

## Listák

1. [Független államok](./names-independent.tsv)
1. [Egyéb jogállású területek](./names-other.tsv)

## Lábjegyzetek

| Név | Lábjegyzet |
| --- | ---------- |
| Fehéroroszország | Nemzetközi kapcsolatokban a Belarusz, Belarusz Köztársaság névalak is használható. |
| Németország | Nemzetközi kapcsolatokban a „Németországi Szövetségi Köztársaság” államnév is használható. |
| Szváziföld | Nemzetközi kapcsolatokban idegen nyelvű szövegekben az ENSZ-ben elfogadott névalak (Eswatini) használható. |
| Vatikán | Nemzetközi kapcsolatokban, illetve bizonyos célokra a „Szentszék” elnevezés is használható. |
| Tajvan | ENSZ és egyéb többoldalú kapcsolatokban a „Tajvan, Kína tartománya” magyarázattal kiegészített név is használható. |

## Az ISO 3166 szabványban nem szerepelnek

| Név | Azonosítók |
| --- | ---------- |
| Koszovó | `ZZ ZZZ 900` |

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
    LC_ALL=C.UTF-8 grep -v '^[A-Za-zÁÉÍÓÖŐÚÜŰáéíóöőúüű /-]\+ [A-Z]\{2\} [A-Z]\{3\} [0-9]\{3\}$' names-independent-fixed.txt
    LC_ALL=C.UTF-8 grep -v '^[A-Za-zÁÉÍÓÖŐÚÜŰáéíóöőúüű ()/-]\+ [A-Z]\{2\} [A-Z]\{3\} [0-9]\{3\} > ' names-other-fixed.txt
    ```
1.  Azonosítók ellenőrzése
    ```shell
    wget https://github.com/PrinsFrank/standards/raw/main/src/Country/CountryNumeric.php
    diff <(grep -o "'[0-9]\{3\}'" <CountryNumeric.php|cut -d"'" -f2|sort) <(grep -ho '[0-9]\{3\}' names-*-fixed.txt|sort)
    ```
    ```js
    // https://hu.wikipedia.org/wiki/Orsz%C3%A1gok_%C3%A9s_ter%C3%BCletek_list%C3%A1ja
    Array.from(document.querySelectorAll(".wikitable > tbody > tr > td:first-of-type > a, .wikitable > tbody > tr > td:nth-of-type(3)")).map(e => e.textContent).join("\n");
    ```
    ```shell
    sed -i -e '/^$/N;/^\n$/D' names-wikipedia.txt
    sed -i -e 's/\s\+/ /g' names-wikipedia.txt
    while read -r LINE;do if [ -z "$LINE" ];then echo;else echo -ne "${LINE}\t";fi;done <names-wikipedia.txt >names-wikipedia-fixed.txt
    diff <(tail -n +2 names-independent.tsv|cut -f4|sort) <(cut -f1 names-wikipedia-fixed.txt|sort)
    diff <(tail -n +2 names-independent.tsv|cut -f5|sort) <(cut -f2 names-wikipedia-fixed.txt|sort)
    ```
    ```js
    // https://konzinfo.mfa.gov.hu/kulkepviseletek/osszes
    Array.from(document.querySelectorAll("#hea-country-elements [role='option']")).map(e => e.textContent).join("\n") 
    ```
    ```shell
    diff <(tail -n +2 names-independent.tsv|cut -f4|sort) <(sort names-konzinfo.txt)
    ```
