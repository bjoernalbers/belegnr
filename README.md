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

Source: [GoBD, issue 2023](https://ao.bundesfinanzministerium.de/ao/2023/Anhaenge/BMF-Schreiben-und-gleichlautende-Laendererlasse/Anhang-64/inhalt.html)

Since the use of *foreign* invoice numbers does not guarantee uniqueness of
document numbers, I wrote this little script.
`belegnr` helps with your bookkeeping by creating sequential, unique document
numbers a.k.a "Belegnummern".

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

Run `belegnr` without options (or with -h) to display usage instructions:

```
$ belegnr
Usage: belegnr [OPTIONS]

Options:
  -c  Copy document number (Belegnummer) to macOS clipboard instead to stdout
  -f  File to store the current number (default: ~/.belegnr)
  -h  Display usage and exit
  -n  Create new document number (Belegnummer)
```

To create a new unique document numbers use the -n flag:

```
$ belegnr -n
BE-1000
$ belegnr -n
BE-1001
$ belegnr -n
BE-1002
```

As you can see, document numbering starts at 1000.
The current number is stored in the file `~/.belegnr`:

```
$ cat ~/.belegnr
1002
```

So ff you want to start numbering from a different number, you
can manually create the file with your desired start number.

Running `belegnr -nc` will copy a new document number into your
clipboard (macOS) without displaying it on stdout.

## Uninstallation

Just run this command to remove `belegnr`:

```
sudo rm /usr/local/bin/belegnr
```
