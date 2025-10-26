# belegnr — Generate sequential, unique document numbers (Belegnummern)

`belegnr` is a simple shell script to make you and the Bundesfinanzministerium happy :-)

## Why?

The German Federal Ministry of Finance (Bundesfinanzministerium) mandates that
every document in the accounting system must be assigned a **unique document number**:

> Jedem Geschäftsvorfall muss ein Beleg zugrunde liegen, mit folgenden Inhalten:
>
> - **Eindeutige Belegnummer** (z. B. Index, Paginiernummer, Dokumenten-ID,
>   fortlaufende Rechnungsausgangsnummer)
> - ...
>

Source: [GoBD, issue 2023](https://ao.bundesfinanzministerium.de/ao/2023/Anhaenge/BMF-Schreiben-und-gleichlautende-Laendererlasse/Anhang-64/inhalt.html)

Since the use of *foreign* invoice numbers does not guarantee uniqueness of
document numbers, I wrote this little script.
`belegnr` helps with your bookkeeping by creating sequential, unique document
numbers a.k.a "Belegnummern".

## Usage

`belegnr` is a shell script to create such document numbers (Belegnummern).
The current number is stored in the file `~/.belegnr`.
