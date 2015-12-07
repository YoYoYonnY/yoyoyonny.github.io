PO Schakeling
=============

Voor het openen en controleren van de schakeling voer je de volgende stappen uit:

  Open [De testpagina](https://yoyoyonny.github.io/schakeling/bin)

of

  1. Open schakeling.coffee.
  2. Open [De Coffeescript REPL Online Interpreter](https://repl.it/languages/coffeescript).
  3. Kopieer de code uit schakeling.coffee naar REPL.
  4. Pas eventueel de test aan door extra commando's toe te voegen.
  5. Druk op RUN.

Commando's
----------

Een commando wordt op de volgende manier aangeroepen:

    commando_naam() # De haakjes zijn verplicht als er geen argumenten zijn.
    commando_naam(arg1, arg2, arg3...)
    commando_naam arg1, arg2, arg3... # De haakjes zijn optioneel als er wel argumenten zijn.

De volgende commando's kunnen uitgevoerd worden:

|Commando  |Argumenten            |Uitleg                                                           |
|:---------|:---------------------|:----------------------------------------------------------------|
|`press`   |`component`           |Druk component in.                                               |
|`press`   |`component`, `stappen`|Druk component in voor maximaal stappen stappen.                 |
|`release` |`component`           |Stop met het indrukken van component.                            |
|`watch`   |`component`           |Bekijk het component component.                                  |
|`watch`   |`component`, `naam`   |Bekijk het component component onder de naam naam.               |
|`unwatch` |`component`           |Stop met het bekijken van het component.                         |
|`debug`   |`component`           |Bekijk het component component in debug mode.                    |
|`debug`   |`component`, `naam`   |Bekijk het component component onder de naam naam in debug mode. |
|`undebug` |`component`           |Stop met het bekijken van het component component in debug mode. |
|`log`     |                      |Schrijf alle componenten waar naar gekeken wordt naar de console.|
|`simulate`|`stappen`             |Simuleer stappen stappen.                                        |

Waarden
-------

De volgende waarden kunnen worden bekeken:

|Waarde        |Uitleg                                                 |
|:-------------|:------------------------------------------------------|
|`button_0`    |De 0-knop.                                             |
|`button_1`    |De 1-knop.                                             |
|`button_2`    |De 2-knop.                                             |
|`button_3`    |De 3-knop.                                             |
|`button_4`    |De 4-knop.                                             |
|`button_5`    |De 5-knop.                                             |
|`button_6`    |De 6-knop.                                             |
|`button_7`    |De 7-knop.                                             |
|`button_8`    |De 8-knop.                                             |
|`button_9`    |De 9-knop.                                             |
|`button_reset`|De RESET-knop.                                         |
|`switch_mode` |De mode-switch.                                        |
|`input_0`     |De 1-bit van de input.                                 |
|`input_1`     |De 2-bit van de input.                                 |
|`input_2`     |De 4-bit van de input.                                 |
|`input_3`     |De 8-bit van de input.                                 |
|`input_any`   |Geeft aan of er een getal-knop is ingedrukt.           |
|`current`     |Geeft aan welk getal er op dit moment vergeleken wordt.|
|`ref_0`       |Het eerste referentiegetal.                            |
|`ref_1`       |Het tweede referentiegetal.                            |
|`ref_2`       |Het derde referentiegetal.                             |
|`ref_3`       |Het vierde referentiegetal.                            |
|`inp_0`       |Het eerste invoergetal.                                |
|`inp_1`       |Het tweede invoergetal.                                |
|`inp_2`       |Het derde invoergetal.                                 |
|`inp_3`       |Het vierde invoergetal.                                |
|`correct_0`   |Geeft aan of het 1e getal in de pincode correct is.    |
|`correct_1`   |Geeft aan of het 2de getal in de pincode correct is.   |
|`correct_2`   |Geeft aan of het 3de getal in de pincode correct is.   |
|`correct_3`   |Geeft aan of het 4de getal in de pincode correct is.   |
|`correct`     |Geeft aan of de pincode correct is.                    |
