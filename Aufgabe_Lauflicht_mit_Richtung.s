.syntax unified // es wird die neueste Syntax (= Regelsystem für die Darstellung von Befehlen) verwendet
// -------------- Konstantendeklaration -----------------------------------------------------------
// Portdeklarationen - Jeder Port hat 12 Konfigurationsregister -> Offsetadressen
GPIOA = 0x40020000 // Basisadresse Port A (16 Bit)
GPIOB = 0x40020400 // Basisadresse Port B (16 Bit)
GPIOC = 0x40020800 // Basisadresse Port C (16 Bit)
GPIOD = 0x40020C00 // Basisadresse Port D (16 Bit)
GPIOE = 0x40021000 // Basisadresse Port E (16 Bit)
GPIOH = 0x40021C00 // Basisadresse Port H (16 Bit)
// Port-Offsetadressen - Adressen für je 4 Byte -> Konfigurationsregister
MODER = 0x00 // Modifikationsregister - 2 Bit/Portpin {input // output // alternate Funktion // analog mod}
OTYPER = 0x04 // Out-Put-Type-Register nur untere 16 Bit (1 Bit/Portpin) {push-pull // open-drain}
OSPEEDR = 0x08 // Out-Put-Speed-Register - 2 Bit/Portpin {low // medium // fast // high } speed
PUPDR = 0x0C // Pull-Up-Down-Register - 2 Bit/Portpin {no pull-up/down // pull-up // pull-down // reserved}
IDR = 0x10 // Input-Data-Register nur untere 16 Bit - read-only
ODR = 0x14 // Output-Data-Register nur untere 16 Bit - read and write
BSRR = 0x18 // Bit-Set/Reset-Register
LCKR = 0x1C // configuration Lock Register
AFRL = 0x20 // Alternate Funktion Register Low
AFRH = 0x24 // Alternate Funktion Register High
RCC = 0x40023800 // Reset and Clock-Control-Register
RCC_AHB1ENR = 0x30 // peripheral clock enable register -> Freigabe der Ports
// -------------- Code Section -----------------------------------------------------------------
.section .text // Bereich für Instruktionen (.data = Bereich für initialisierte Daten, .bss = uninitialisierte)
.global main // main kann von anderem File verwendet werden (von startup_stm32f411xe.s)
// -------------- Hauptprogramm ----------------------------------------------------------------
main:
    ldr R1,=RCC // R1 = Adresse von rcc (siehe equ-Anweisung)
    ldr R2,[r1,RCC_AHB1ENR] // R2 = Inhalt der Adrese[rcc+offset AVB1ENR]
    orr R2,0x7 // setze die unteren 3 Bit von R2 auf ‚1‘
    str R2,[r1,RCC_AHB1ENR] // Speicherzelle[RCC+offset AVB1ENR] = R2
    
    // GPIOB ---- Input------------------------------
    // TODO ersetze ? durch 3 Befehle um das Lowerbyte von Port B als Eingang zu nutzen
	?
    
    // GPIOC ---- Output------------------------------
    ldr R1,=GPIOC // R1 = Basisadresse von Port C
    ldr R2,=0x55555555 // MODER_von_C = 01_01_01_01_01_01_01_01_01_01_01_01_01_01_01_01
    str R2,[R1,MODER] // Port C ist Output (10)
    mov R2,0x0000 // OTYPER_von_C = 0_0_0_0_0_0_0_0_0_0_0_0_0_0_0_0
    strh R2,[R1,OTYPER] // Port C ist push-pull-Ausgang


    // ----- unser Programm -----
    mov r2,0x01         // Initialisierung des Ausgabewertes
loop:
    // Herausschreiben auf die LEDs an PortC[7:0]
    ldr r1,=GPIOC       // Laden der Basisadresse von PortC in R1
    strb r2,[r1,#ODR]   // Schreiben des Inhalts (unteres Byte) 
                        // von R2 auf das Output-Data-Register (ODR)
                        // von PortC, also an die LEDs

    // Frage PortB.0 ab, ob links oder rechts herum
    ldr r1,=GPIOB
	// TODO ersetze ? um das Lowerbyte von Port B in r3 einzulesen
    ?   // Lade vom Input-Data-Register des PortB

	// TODO ersetze ? um alle Bits in r3 außer dem hintersten auszumaskieren
    ? // alle Bits außer das unterste ausmaskieren
	// TODO ersetze ? um zu prüfen ob das hinterste Bit in r3 gesetzt war
    ? // vergleiche r3 und 0x01 für Richtung des Lauflichts
    bne rechts_schieben // Wenn Schalter nicht 1 ist springe nach "rechts_schieben"

links_schieben:
    // Schieben um ein Bit nach Links
    // TODO ersetze ? um das Muster in r2 um eins nach links zu schieben 
	?
    // Vergleichen, ob der Wert mehr als 8 Bit hat / zu groß ist
	// TODO ersetze ? um zu Prüfen, ob das Bitmuster mehr als 8 Bit braucht
    ?
    ble dahinter    // Überspringe den nächsten Befehl, wenn
                    // wir noch im "sichtbaren" Bereich sind
        mov r2,#1   // ansonsten fange von vorne an
dahinter:
    
    b ende_if       // überspringe den else-Zweig (=rechts)

rechts_schieben:
    // Schieben um ein Bit nach Rechts
    // TODO ersetze ? um das Muster in r2 um eins nach rechts zu schieben 
	?
    // Vergleichen, ob wir noch etwas sehen
    // TODO ersetze ? um zu Prüfen, ob das Bitmuster ein Reset braucht
	?
    bne dahinter2   // Überspringe den nächsten Befehl, wenn
                    // wir noch im "sichtbaren" Bereich sind
        mov r2,#128 // ansonsten fange von vorne an
dahinter2:

ende_if:

    // warten etwas damit das Lauflicht nicht zu schnell ist 
    ldr r4,=500000     // Angabe, wie lange wir warten wollen
warten_durch_zaehlen:
    sub r4,#1           // ziehe 1 von R4 ab (r4--)
    cmp r4,#0           // vergleiche R4 mit Null   
    bne warten_durch_zaehlen     // springe zum Schleifenanfang, 
    
    b loop // Springe (branch) zum Label loop = Endlosschleife