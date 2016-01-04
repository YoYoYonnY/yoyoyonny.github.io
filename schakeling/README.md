PO Schakeling
=============

Voor het openen van de diavoorstelling:

  Open [De diavoorstelling](https://docs.google.com/presentation/d/1iz511oMMnfI7oULQouWYtTknblxvZaT-IJXeOTgC53M)

Voor het openen en controleren van de schakeling voer je de volgende stappen uit:

  Open [De testpagina](https://yoyoyonny.github.io/schakeling/bin)

Voor het weergeven van de uitleg

  Open [De source](https://github.com/YoYoYonnY/yoyoyonny.github.io/blob/master/schakeling/src/schakeling.litcoffee)

De schakeling in tekstformaat (Origineel):

    button_0 = Button
    button_1 = Button
    button_2 = Button
    button_3 = Button
    button_4 = Button
    button_5 = Button
    button_6 = Button
    button_7 = Button
    button_8 = Button
    button_9 = Button
    button_reset = Button
    # button_clear werkt niet,
    # de pulsenteller kan in systematic n.m.l. niet terugtellen
    button_clear = Button
    switch_mode = Switch

    input_0 = OR(button_1, button_3, button_5, button_7, button_9)
    input_1 = OR(button_2, button_3, button_6, button_7)
    input_2 = OR(button_4, button_5, button_6, button_7)
    input_3 = OR(button_8, button_9)

    input_any = OR(button_0, button_1, button_2, button_3, button_4,
                   button_5, button_6, button_7, button_8, button_9)

    current = PulsenTeller
    current.set = AND(NOT(current[2]), NOT(input_any))
    current.reset = button_reset
    current_0    = AND(NOT(current[0]), NOT(current[1]), NOT(current[2]))
    current_1    = AND(    current[0] , NOT(current[1]), NOT(current[2]))
    current_2    = AND(NOT(current[0]),     current[1] , NOT(current[2]))
    current_3    = AND(    current[0] ,     current[1] , NOT(current[2]))
    current_done = AND(NOT(current[0]), NOT(current[1]),     current[2] )

    # MemoryCell_4bit[0] = MemoryCell
    # MemoryCell_4bit[1] = MemoryCell
    # MemoryCell_4bit[2] = MemoryCell
    # MemoryCell_4bit[3] = MemoryCell

    ref_0 = MemoryCell_4bit
    ref_1 = MemoryCell_4bit
    ref_2 = MemoryCell_4bit
    ref_3 = MemoryCell_4bit

    ref_0[0].set = AND(current_0, input_0, switch_mode)
    ref_0[1].set = AND(current_0, input_1, switch_mode)
    ref_0[2].set = AND(current_0, input_2, switch_mode)
    ref_0[3].set = AND(current_0, input_3, switch_mode)

    ref_1[0].set = AND(current_1, input_0, switch_mode)
    ref_1[1].set = AND(current_1, input_1, switch_mode)
    ref_1[2].set = AND(current_1, input_2, switch_mode)
    ref_1[3].set = AND(current_1, input_3, switch_mode)

    ref_2[0].set = AND(current_2, input_0, switch_mode)
    ref_2[1].set = AND(current_2, input_1, switch_mode)
    ref_2[2].set = AND(current_2, input_2, switch_mode)
    ref_2[3].set = AND(current_2, input_3, switch_mode)

    ref_3[0].set = AND(current_3, input_0, switch_mode)
    ref_3[1].set = AND(current_3, input_1, switch_mode)
    ref_3[2].set = AND(current_3, input_2, switch_mode)
    ref_3[3].set = AND(current_3, input_3, switch_mode)

    ref_0[0].reset = AND(button_reset, switch_mode)
    ref_0[1].reset = AND(button_reset, switch_mode)
    ref_0[2].reset = AND(button_reset, switch_mode)
    ref_0[3].reset = AND(button_reset, switch_mode)

    ref_1[0].reset = AND(button_reset, switch_mode)
    ref_1[1].reset = AND(button_reset, switch_mode)
    ref_1[2].reset = AND(button_reset, switch_mode)
    ref_1[3].reset = AND(button_reset, switch_mode)

    ref_2[0].reset = AND(button_reset, switch_mode)
    ref_2[1].reset = AND(button_reset, switch_mode)
    ref_2[2].reset = AND(button_reset, switch_mode)
    ref_2[3].reset = AND(button_reset, switch_mode)

    ref_3[0].reset = AND(button_reset, switch_mode)
    ref_3[1].reset = AND(button_reset, switch_mode)
    ref_3[2].reset = AND(button_reset, switch_mode)
    ref_3[3].reset = AND(button_reset, switch_mode)

    compare = (a, b) -> NOT(XOR(a, b))

    inp_0 = MemoryCell_4bit
    inp_1 = MemoryCell_4bit
    inp_2 = MemoryCell_4bit
    inp_3 = MemoryCell_4bit

    inp_0[0].set = AND(current_0, input_0, NOT(switch_mode))
    inp_0[1].set = AND(current_0, input_1, NOT(switch_mode))
    inp_0[2].set = AND(current_0, input_2, NOT(switch_mode))
    inp_0[3].set = AND(current_0, input_3, NOT(switch_mode))

    inp_1[0].set = AND(current_1, input_0, NOT(switch_mode))
    inp_1[1].set = AND(current_1, input_1, NOT(switch_mode))
    inp_1[2].set = AND(current_1, input_2, NOT(switch_mode))
    inp_1[3].set = AND(current_1, input_3, NOT(switch_mode))

    inp_2[0].set = AND(current_2, input_0, NOT(switch_mode))
    inp_2[1].set = AND(current_2, input_1, NOT(switch_mode))
    inp_2[2].set = AND(current_2, input_2, NOT(switch_mode))
    inp_2[3].set = AND(current_2, input_3, NOT(switch_mode))

    inp_3[0].set = AND(current_3, input_0, NOT(switch_mode))
    inp_3[1].set = AND(current_3, input_1, NOT(switch_mode))
    inp_3[2].set = AND(current_3, input_2, NOT(switch_mode))
    inp_3[3].set = AND(current_3, input_3, NOT(switch_mode))
    inp_0[0].reset = AND(button_reset, NOT(switch_mode))
    inp_0[1].reset = AND(button_reset, NOT(switch_mode))
    inp_0[2].reset = AND(button_reset, NOT(switch_mode))
    inp_0[3].reset = AND(button_reset, NOT(switch_mode))

    inp_1[0].reset = AND(button_reset, NOT(switch_mode))
    inp_1[1].reset = AND(button_reset, NOT(switch_mode))
    inp_1[2].reset = AND(button_reset, NOT(switch_mode))
    inp_1[3].reset = AND(button_reset, NOT(switch_mode))

    inp_2[0].reset = AND(button_reset, NOT(switch_mode))
    inp_2[1].reset = AND(button_reset, NOT(switch_mode))
    inp_2[2].reset = AND(button_reset, NOT(switch_mode))
    inp_2[3].reset = AND(button_reset, NOT(switch_mode))

    inp_3[0].reset = AND(button_reset, NOT(switch_mode))
    inp_3[1].reset = AND(button_reset, NOT(switch_mode))
    inp_3[2].reset = AND(button_reset, NOT(switch_mode))
    inp_3[3].reset = AND(button_reset, NOT(switch_mode))
    correct_0 = AND(
        compare(inp_0[0], ref_0[0]),
        compare(inp_0[1], ref_0[1]),
        compare(inp_0[2], ref_0[2]),
        compare(inp_0[3], ref_0[3]) )
    correct_1 = AND(
        compare(inp_1[0], ref_1[0]),
        compare(inp_1[1], ref_1[1]),
        compare(inp_1[2], ref_1[2]),
        compare(inp_1[3], ref_1[3]) )
    correct_2 = AND(
        compare(inp_2[0], ref_2[0]),
        compare(inp_2[1], ref_2[1]),
        compare(inp_2[2], ref_2[2]),
        compare(inp_2[3], ref_2[3]) )
    correct_3 = AND(
        compare(inp_3[0], ref_3[0]),
        compare(inp_3[1], ref_3[1]),
        compare(inp_3[2], ref_3[2]),
        compare(inp_3[3], ref_3[3]) )
    correct = LED
    correct.set = AND(correct_0, correct_1, correct_2, correct_3,
        current_done)
    incorrect = LED
    incorrect.set = AND(NAND(correct_0, correct_1, correct_2, correct_3),
        current_done)

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
