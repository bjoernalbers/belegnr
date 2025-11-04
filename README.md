# belegnr — Generate sequential, unique document numbers (Belegnummern)

`belegnr` is a simple shell script to make you and the Finanzamt happy :-)

## Why?

The German Federal Ministry of Finance (Bundesfinanzministerium) mandates that
every document in your accounting must be assigned a **unique document number**:

> Jedem Geschäftsvorfall muss ein Beleg zugrunde liegen, mit folgenden Inhalten:
>
> - **Eindeutige Belegnummer** (z. B. Index, Paginiernummer, Dokumenten-ID,
>   fortlaufende Rechnungsausgangsnummer)
> - ...

Source: [GoBD, issue 2023](https://ao.bundesfinanzministerium.de/ao/2023/Anhaenge/BMF-Schreiben-und-gleichlautende-Laendererlasse/Anhang-64/inhalt.html)

Using *external invoice numbers* as document numbers is a recipe for disaster
because they *do not guarantee uniqueness*.

`belegnr` helps with your bookkeeping by creating sequential, unique document
numbers a.k.a. Belegnummern.

## Installation

The [macOS installer](https://github.com/bjoernalbers/belegnr/releases/latest/download/belegnr.pkg)
will install `belegnr` under `/usr/local/bin/belegnr`.

To install it manually:

```
sudo curl -fsSL -o /usr/local/bin/belegnr \
    https://github.com/bjoernalbers/belegnr/releases/latest/download/belegnr \
    && sudo chmod +x /usr/local/bin/belegnr
```

You can also clone this repository and run `make install`.

## Usage

Run `belegnr` without options (or with `-h` flag) to display usage
instructions:

```
$ belegnr
belegnr — Generate sequential, unique document numbers (Belegnummern)

Usage: belegnr [OPTIONS]

Options:
  -c  Create new Belegnummer
  -h  Display this help and exit
  -p  Print current Belegnummer
  -r  Reset counter (~/.belegnr) to given value, i.e. -r 1000
```

To create a new unique Belegnummer, use the `-c` flag:

```
$ belegnr -c
BE-1
$ belegnr -c
BE-2
$ belegnr -c
BE-3
```

To start at a different number, just reset the counter:

```
$ belegnr -r 1000
Really reset counter? (y/N): y
BE-1000
```

The counter is stored in the file `~/.belegnr`:

```
$ cat ~/.belegnr
1000
```

## Uninstallation

Just run this command to remove `belegnr`:

```
sudo rm /usr/local/bin/belegnr
```
