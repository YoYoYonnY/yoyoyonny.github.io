PO Pincode
==========

Componenten
-----------

Voor dit programma om uitvoerbaar te zijn zullen er een aantal componenten
 aan het programma toegevoegd worden.

    components = [] # Lijst met alle componenten die ooit gecreeërd zijn
    class Component
        constructor: (@name=null) ->
            components.push this
        setState: -> no
        getState: -> off
        setName: (name) ->
            @name = name
            return this
        getName: -> @name
        simulate: ->
        copy: (name)  ->
            copy = new Component @name
            copy.name ?= name
            copy.title ?= @title
            copy.getState = @getState
            copy.setState = @setState
            copy.getName = -> @name
            copy.setName = -> no
            copy.getTitle = -> @title
            copy.setTitle = -> no
            return copy
        log: (output=console)  ->
            name = @getTitle?() or @getName?() or "unnamed"
            state = if @getState() then "on" else "off"
            output.log "#{name}: #{state}"
    class BitHolder extends Component
        constructor: (name=null) ->
            super(name)
            state = off
            @setState = (_state) ->
                state = stateof _state
                return yes
            @getState = -> state
    class Pressable extends Component
        constructor: (name) ->
            super(name)
        press: ->
        release: ->
    class Button extends Pressable
        constructor: (name=null, @title=name) ->
            super(name)
            state = off
            releaseDelay = 0
            @press = (steps=0) ->
                state = on
                releaseDelay = steps + 1
            @release = ->
                state = off
            @setTitle = (_title) ->
                @title = _title
                return this
            @getTitle = -> @title
            @getState = -> state
            @simulate = ->
                if releaseDelay > 0
                    releaseDelay--
                    if releaseDelay is 0
                        state = off
    class Switch extends Pressable
        constructor: (name=null, @title=name) ->
            super(name)
            state = off
            pressed = no
            releaseDelay = 0
            @press = (steps=0) ->
                state = not state if not pressed
                pressed = yes
                releaseDelay = steps
            @release = ->
                pressed = no
            @setTitle = (_title) ->
                @title = _title
                return this
            @getTitle = -> @title
            @getState = -> state
            @simulate = ->
                if releaseDelay > 0
                    releaseDelay--
                    if releaseDelay is 0
                        pressed = no
    class LED extends BitHolder
        constructor: (name=null, @title=name) ->
            super(name)
            state = off
            @set = false
            @setTitle = (_title) -> @title = _title
            @getTitle = -> @title
            @setState = (_state) ->
                state = stateof _state
                return yes
            @getState = -> state
            @simulate = ->
                if stateof @set
                    state = on
                else
                    state = off
    class Lamp extends BitHolder
        constructor: (name=null, @title=name) ->
            super(name)
            state = off
            @set = false
            @setTitle = (_title) -> @title = _title
            @getTitle = -> @title
            @setState = (_state) ->
                state = stateof _state
                return yes
            @getState = -> state
            @simulate = ->
                if stateof @set
                    state = on
                else
                    state = off
        log: (output=console)  ->
            name = @title or "unnamed"
            state = if @getState() then "on" else "off"
            output.log "#{name}: #{state}"
    class PulseCounter extends Component
        getbit = (number, bit) -> (number & ( 1 << bit )) >> bit
        regenerate = (self, number) ->
            self[0].setState(getbit(number, 0))
            self[1].setState(getbit(number, 1))
            self[2].setState(getbit(number, 2))
            self[3].setState(getbit(number, 3))
        constructor: (name=null) ->
            super(name)
            updating = no
            number = 0
            @[0] = new BitHolder (name + "[0]")
            @[1] = new BitHolder (name + "[1]")
            @[2] = new BitHolder (name + "[2]")
            @[3] = new BitHolder (name + "[3]")
            @set = null
            @reset = null
            @enabled = yes
            @simulate = =>
                if stateof @enabled
                    if stateof @set
                        if updating
                            updating = no
                            regenerate(this, ++number)
                    else
                        if not updating
                            updating = yes
                    if stateof @reset
                        regenerate(this, number = 0)
                        updating = no
            @log = (console=console) ->
                name = @getName() or "unnamed"
                bits = (if stateof @[3] then '1' else '0') +
                       (if stateof @[2] then '1' else '0') +
                       (if stateof @[1] then '1' else '0') +
                       (if stateof @[0] then '1' else '0')
                number = ( (stateof @[0]) * 1 +
                           (stateof @[1]) * 2 +
                           (stateof @[2]) * 4 +
                           (stateof @[3]) * 8 )
                state = "#{number} (#{bits})"
                console.log "#{name}: #{state}"
        copy: (name) =>
            copy = new PulseCounter @name
            copy.name = name if name?
            copy.getName = -> @name
            copy.setName = -> false
            for n in [0..3]
                copy[n] = @[n].copy(copy.name + '[' + name + ']')
            return copy
    class PulseGenerator extends BitHolder
        constructor: (name=null, onTime=1, offTime=1) ->
            super(name)
            state = off
            time = 0
            @getState = -> state
            @setState = (_state) ->
                state = _state
                return yes
            @simulate = ->
                if time > 0
                    time--
                    if time is 0
                        if state
                            time = offTime
                        else
                            time = onTime
                        state = not state
    class MemoryCell extends BitHolder
        constructor: (name=null) ->
            super(name)
            state = off
            @set = null
            @reset = null
            @setState = (_state) ->
                state = _state
                return yes
            @getState = -> state
            @simulate = ->
                if stateof @set
                    if not stateof @reset
                        state = on
                else if stateof @reset
                    state = off

    class MemoryCell_4bit extends Component
        constructor: (name=null) ->
            super(name)
            @[0] = new MemoryCell name+"[0]"
            @[1] = new MemoryCell name+"[1]"
            @[2] = new MemoryCell name+"[2]"
            @[3] = new MemoryCell name+"[3]"
        log: (console=console) ->
            name = @getName() or "unnamed"
            bits = (if stateof @[3] then '1' else '0') +
                   (if stateof @[2] then '1' else '0') +
                   (if stateof @[1] then '1' else '0') +
                   (if stateof @[0] then '1' else '0')
            number = ( (stateof @[0]) * 1 +
                       (stateof @[1]) * 2 +
                       (stateof @[2]) * 4 +
                       (stateof @[3]) * 8 )
            state = "#{number} (#{bits})"
            console.log "#{name}: #{state}"
        copy: (name) ->
            copy = new MemoryCell_4bit @name
            copy.name = name if name?
            copy.getName = -> @name
            copy.setName = -> false
            for n in [0..3]
                copy[n] = @[n].copy(copy.name + '[' + name + ']')
            return copy

    generateLogicCircuit = (name, getState) ->
        component = new Component name
        component.getState = -> stateof getState()
        return component

STATEOF
-------

`stateof` is een belangerijke functie. Met `stateof` kunnen we de waarde van
 een component met één uitvoer lezen.

    stateof = (component) ->
        if component instanceof Component
            component.getState()
        else if typeof component is "number"
            component isnt 0
        else if typeof component is "boolean"
            component
        else
            off

Simuleren
---------

We zullen ook een aantal functies voor simuleren definiëren:

    # Watching is een lijst met componenten die we aan het bekijken zijn.
    watching = []
    # Debugging is een lijst met componenten die we aan het debugggen zijn.
    debugging = []
    # Press is een functie die het indrukken van een knop simuleert.
    press = (component, steps=0) -> component.press steps
    # Release is een functie die het loslaten van een knop simuleert.
    release = (component) -> component.release()
    # Watch is een functie die een component op de kijklijst plaatst.
    watch = (component, name=null) ->
        watching.push component.copy name
    # Unwatch is een functie die een component van de kijklijst haalt.
    unwatch = (component) ->
        watching = (x for x in watching when x isnt component)
    # Debug is een functie die een component op de debuglijst plaatst.
    debug = (component, name=null) ->
        debugging.push component.copy name
    # Undebug is een functie die een component van de debuglijst haalt.
    undebug = (component) ->
        debugging = (x for x in debugging when x isnt component)
    # Log is een functie die de gegevens van alle componenten naar de Console
    # zal schrijven.
    log = ->
        for component in watching
            component.log(console)
        return
    # Simulate is een functie die de simulatie voor een aantal stappen
    # simuleert.
    simulate = (steps=1) ->
        for n in [1..steps]
            for component in components
                component.simulate()
                component.log() if component in debugging
        return
    class Time
        @MILISECOND: 1
        @SECOND: 1000
        @MINUTE: 60000

Logische poorten
----------------

De volgende logische poorten moeten gedefiniërd worden:

    # Een OF-poort geeft een hoog signaal als er minstens een input hoog is.
    # (er is een `on` in de argumenten)
    OR = (args...) -> generateLogicCircuit "OR", ->
            _args = (stateof arg for arg in args)
            return on in _args
    # Een EN-poort geeft een hoog signaal als er geen input laag is.
    # (er is geen `off` in de argumenten)
    AND = (args...) -> generateLogicCircuit "AND", ->
        _args = (stateof arg for arg in args)
        return not (off in _args)
    # Een XOR-poort geeft een hoog signaal als het aantal inputs dat hoog is
    #  gelijk is aan een.
    XOR = (args...) -> generateLogicCircuit "XOR", ->
        _args = (stateof arg for arg in args)
        return (arg for arg in _args when arg is on).length is 1
    # Een NIET-poort draait zijn argument om.
    NOT = (arg) -> generateLogicCircuit "NOT", ->
        return not stateof arg

De volgende logische poorten kunnen algebratisch gegenereerd worden:

    # Een NAND(...) poort is gelijk aan een NOT(AND(...)) poort
    NAND = (args...) -> generateLogicCircuit "NAND", -> NOT AND args...
    # Een NOR(...) poort is gelijk aan een NOT(OR(...)) poort
    NOR = (args...) -> generateLogicCircuit "NOR", -> NOT OR args...

Het programma starten
---------------------

    # Imports slaat alle componenten op onder de juiste naam.
    imports = {}
    # Run start de simulatie, als die bestaat.
    run = ->
        watching = []
        debugging = []
        main?(imports)
    # Start start het programma.
    start = ->
        init?()
        for component in components
            imports[component.name] = component
        if window? and document? # De code wordt in de browser uitgevoert
            addEventListener "DOMContentLoaded", ->
                buttonsDiv  = document.createElement 'div'
                switchesDiv = document.createElement 'div'
                lampsDiv    = document.createElement 'div'
                ledsDiv     = document.createElement 'div'
                watchingDiv = document.createElement 'div'
                watchingDiv.className = "watching"
                buttons  = []
                switches = []
                lamps    = []
                leds     = []
                updateSwitches = ->
                    for _switch in switches
                        [name, div] = _switch
                        active = imports[name].getState()
                        active = if active then"active" else ""
                        div.className = "switch " + active
                updateLamps = ->
                    for lamp in lamps
                        [name, div] = lamp
                        active = imports[name].getState()
                        active = if active then"active" else ""
                        div.className = "lamp " + active
                updateLeds = ->
                    for led in leds
                        [name, div] = led
                        active = imports[name].getState()
                        active = if active then "active" else ""
                        div.className = "led " + active
                updateWatchList = ->
                    while watchingDiv.firstChild
                        watchingDiv.removeChild watchingDiv.firstChild
                    for component in watching
                        text = ""
                        _console =
                            log: (args...) ->
                                text += arg for arg in args
                            debug: ->
                            error: ->
                            clear: ->
                        component.log(_console)
                        div = document.createElement 'div'
                        div.appendChild document.createTextNode text
                        watchingDiv.appendChild div

                updateComponents = ->
                    updateSwitches()
                    updateLamps()
                    updateLeds()
                    updateWatchList()
                buttons.className = "buttons"
                lamps.className   = "lamps"
                leds.className    = "leds"
                for component in components
                    do (component) ->
                        if component instanceof Button
                            button = document.createElement 'button'
                            button.className = "button"
                            button.appendChild document.createTextNode component.title
                            button.addEventListener 'click', (e) =>
                                press component, 1
                                simulate 10
                                updateComponents()
                            buttons.push [component.name, button]
                            buttonsDiv.appendChild button
                        else if component instanceof Switch
                            _switch = document.createElement 'button'
                            _switch.className = "switch"
                            _switch.appendChild document.createTextNode component.title
                            _switch.addEventListener 'click', (e) =>
                                press component, 1
                                simulate 10
                                updateComponents()
                            switches.push [component.name, _switch]
                            switchesDiv.appendChild _switch
                        else if component instanceof Lamp
                            lamp = document.createElement 'div'
                            lamp.className = "lamp"
                            lamp.appendChild document.createTextNode component.title
                            lamps.push [component.name, lamp]
                            lampsDiv.appendChild lamp
                        else if component instanceof LED
                            led = document.createElement 'div'
                            led.className = "led"
                            led.appendChild document.createTextNode component.title
                            leds.push [component.name, led]
                            ledsDiv.appendChild led
                run()
                updateComponents()
                start = document.createElement 'button'
                start.className = "start"
                start.appendChild document.createTextNode "Reset Simulation"
                start.addEventListener "click", (e) =>
                    run()
                    updateComponents()

                document.body.appendChild buttonsDiv
                document.body.appendChild switchesDiv
                document.body.appendChild lampsDiv
                document.body.appendChild ledsDiv
                document.body.appendChild watchingDiv
                document.body.appendChild start
        else if exports? # De code wordt in de console uitgevoert
            run()

De schakeling
=============

De schakeling zal worden gedefiniërd binnen de `init` functie.

    init = ->

De schakeling bestaat uit de volgende componenten:

 - Invoer
 - Instellen
 - Vergelijken
 - Uitvoer

Invoer
------

De invoer bestaat uit de nummers 0-9, een reset- en clear-knop en een
 mode switch.
De mode knop zal alleen toegankelijk zijn voor de operator van de schakeling.

        button_0 = new Button "button_0", "0"
        button_1 = new Button "button_1", "1"
        button_2 = new Button "button_2", "2"
        button_3 = new Button "button_3", "3"
        button_4 = new Button "button_4", "4"
        button_5 = new Button "button_5", "5"
        button_6 = new Button "button_6", "6"
        button_7 = new Button "button_7", "7"
        button_8 = new Button "button_8", "8"
        button_9 = new Button "button_9", "9"
        button_reset = new Button "button_reset", "RESET"
        # button_clear werkt niet,
        # de pulsenteller kan in systematic n.m.l. niet terugtellen
        button_clear = new Button "button_clear", "CLEAR"
        switch_mode = new Switch "switch_mode", "MODE"

De nummers worden omgezet naar een 4 bit binair getal, d.m.v. OF poorten.

        input_0 = OR(button_1, button_3, button_5, button_7, button_9)
                  .setName("input_0")
        input_1 = OR(button_2, button_3, button_6, button_7)
                  .setName("input_1")
        input_2 = OR(button_4, button_5, button_6, button_7)
                  .setName("input_2")
        input_3 = OR(button_8, button_9)
                  .setName("input_3")

Ook zal er een signaal worden gegenereerd dat aan gaat als een van de
 nummertoetsen ingedrukt is.

        input_any = OR(button_0, button_1, button_2, button_3, button_4,
                       button_5, button_6, button_7, button_8, button_9)
                    .setName("input_any")

Voor het onthouden van welk getal we op dit moment in aan het voeren zijn
 zullen we een pulsenteller gebruiken.

        current = new PulseCounter "current"
        current.set = AND(NOT(current[2]), NOT(input_any))
        # Hier zou de `button_clear` knop aangesloten worden,
        # om de 'current' pulsenteller omlaag te laten tellen.
        current.reset = button_reset
        current_0    = AND(NOT(current[0]), NOT(current[1]), NOT(current[2]))
                     .setName("current_0")
        current_1    = AND(    current[0] , NOT(current[1]), NOT(current[2]))
                     .setName("current_1")
        current_2    = AND(NOT(current[0]),     current[1] , NOT(current[2]))
                     .setName("current_2")
        current_3    = AND(    current[0] ,     current[1] , NOT(current[2]))
                     .setName("current_3")
        current_done = AND(NOT(current[0]), NOT(current[1]),     current[2] )
                     .setName("current_done")

Instellen
---------

Het instelgedeelte van de schakeling is alleen in gebruikt als de mode switch
 aan staat.
Voor elk getal zal er een vier-bit geheugencel zijn die de bits van de in te
 stellen getallen onthouden.

        ref_0 = new MemoryCell_4bit "ref_0"
        ref_1 = new MemoryCell_4bit "ref_1"
        ref_2 = new MemoryCell_4bit "ref_2"
        ref_3 = new MemoryCell_4bit "ref_3"

Deze geheugencel zal de vier bits van de invoer opslaan, in een andere cel
 afhankelijk van welk getal op dit moment ingevoerd word. De mode switch moet
 aan staan (Wat aangeeft dat de gebruiker de getallen wil instellen).

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

Alle referentiecellen zullen worden gereset als de resetknop word ingedrukt
 terwijl de mode switch aanstaat.

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

Vergelijken
-----------

Voor het vergelijken van de getallen zullen we een simpele schakeling ontwerpen
 die bij de volgende inputs de volgende outputs geeft:

| INPUT 1 | INPUT 2 | OUTPUT |
|:-------:|:-------:|:------:|
|    0    |    0    |    1   |
|    0    |    1    |    0   |
|    1    |    0    |    0   |
|    1    |    1    |    1   |

De schakeling zal dus een hoog signaal geven als output als beide inputs
 hetzelde zijn.
Voor het maken van deze schakeling zullen we gebruik maken van een
 geinverteerde XOF poort. De XOF poort geeft immers een hoog signaal als beide
 inputs verschillend zijn.
We zullen dit component `compare` noemen.

        compare = (a, b) -> NOT(XOR(a, b))

We zullen de input opslaan afhankelijk van welk van de getallen word ingevuld.

        inp_0 = new MemoryCell_4bit "inp_0"
        inp_1 = new MemoryCell_4bit "inp_1"
        inp_2 = new MemoryCell_4bit "inp_2"
        inp_3 = new MemoryCell_4bit "inp_3"

Deze geheugencellen zullen dus het laatst ingevoerde getal onthouden.

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

Alle inputcellen zullen worden gereset als de resetknop word ingedrukt terwijl
 de mode switch niet aanstaat.

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

We zullen voor elk getal opslaan of alle bits overeen komen.

        correct_0 = AND(
            compare(inp_0[0], ref_0[0]),
            compare(inp_0[1], ref_0[1]),
            compare(inp_0[2], ref_0[2]),
            compare(inp_0[3], ref_0[3]) )
            .setName("correct_0")
        correct_1 = AND(
            compare(inp_1[0], ref_1[0]),
            compare(inp_1[1], ref_1[1]),
            compare(inp_1[2], ref_1[2]),
            compare(inp_1[3], ref_1[3]) )
            .setName("correct_1")
        correct_2 = AND(
            compare(inp_2[0], ref_2[0]),
            compare(inp_2[1], ref_2[1]),
            compare(inp_2[2], ref_2[2]),
            compare(inp_2[3], ref_2[3]) )
            .setName("correct_2")
        correct_3 = AND(
            compare(inp_3[0], ref_3[0]),
            compare(inp_3[1], ref_3[1]),
            compare(inp_3[2], ref_3[2]),
            compare(inp_3[3], ref_3[3]) )
            .setName("correct_3")

Uitvoer
-------

Voor de uitvoer van de schakeling zullen we controleren of alle getallen uit de
 invoer overeen komt met de referentiewaarden, maar alleen als we alle cijfers
 ingevoerd hebben.

        correct = new LED "correct", "CORRECT"
        correct.set = AND(correct_0, correct_1, correct_2, correct_3,
            current_done)
        incorrect = new LED "incorrect", "INCORRECT"
        incorrect.set = AND(NAND(correct_0, correct_1, correct_2, correct_3),
            current_done)

We zullen voor het gemak alle componenten importeren.

    main = (imports) ->
        { button_0
        , button_1
        , button_2
        , button_3
        , button_4
        , button_5
        , button_6
        , button_7
        , button_8
        , button_9
        , button_reset
        , button_clear
        , switch_mode
        , input_0
        , input_1
        , input_2
        , input_3
        , input_any
        , current
        , current_0
        , current_1
        , current_2
        , current_3
        , ref_0
        , ref_1
        , ref_2
        , ref_3
        , inp_0
        , inp_1
        , inp_2
        , inp_3
        , correct_0
        , correct_1
        , correct_2
        , correct_3
        , correct
        , incorrect
        } = imports

Om het programma te testen zullen we een korte simulatie defineren.

        press switch_mode, 1
        simulate 10

        press button_1, 1
        simulate 10

        press button_2, 1
        simulate 10

        press button_3, 1
        simulate 10

        press button_4, 1
        simulate 10

        press switch_mode, 1
        simulate 10

        press button_reset, 1
        simulate 10

        press button_1, 1
        simulate 10

        press button_2, 1
        simulate 10

        press button_3, 1
        simulate 10

        press button_4, 1
        simulate 10

        watch current, "Huidige getal"

        watch inp_0, "Input Getal 1"
        watch inp_1, "Input Getal 2"
        watch inp_2, "Input Getal 3"
        watch inp_3, "Input Getal 4"

        watch ref_0, "Referentie Getal 1"
        watch ref_1, "Referentie Getal 2"
        watch ref_2, "Referentie Getal 3"
        watch ref_3, "Referentie Getal 4"

        watch correct
        watch incorrect

        log()

Als allerlaatst starten we het programma.

    start()
