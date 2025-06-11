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
	// Port A-C aktivieren
    ldr R1,=RCC // R1 = Basisadresse von rcc 
    ldr R2,[r1,RCC_AHB1ENR] // R2 = Inhalt der Adrese[rcc+offset AVB1ENR]
    orr R2,0x7 // setze die unteren 3 Bit von R2 auf ‚1‘
    str R2,[r1,RCC_AHB1ENR] // Speicherzelle[RCC+offset AVB1ENR] = R2
    
    // GPIOB ---- Input------------------------------
    // TODO(3Zeilen): Lowerbyte von Port B als Eingang einrichten
	?
    
    // GPIOC ---- Output------------------------------
    // TODO(3Zeilen): Lowerbyte von Port C als Ausgang einrichten
	?


    // ----- unser Programm -----
	// register für LED-Muster und Geschwindigkeit initialisieren
    mov r2,0x01         // Startwert LED-Muster
    mov r0, 0x40        // Startwert Geschwindigkeit
loop:
    
    // Herausschreiben auf die LEDs an PortC[7:0]
    // TODO(2 Zeilen): lasse das Bitmuster für das Lauflicht anzeigen 
	?

    // Einlesen von Richtung und Geschwindigkeit
    // TODO(2 Zeilen): lese das Bitmuster für Richtung und Geschwindigkeit 
	?

    
    // Bits für Geschwindigkeit an PortB.1-7 auslesen
	// TODO(2-4 Zeilen): verarbeite die eingelesenen Daten, sodass hinten in r0 die 
	// Bits für die Geschwindigkeit sind 
	?
	
    // Richtung durch PortB.0 ablesen
    // TODO(1-2 Zeilen): extrahiere das Bit für die Richtung in ein eigenes Register
	
	
	// TODO(2 Zeilen) springe zu "rechts_schieben" falls Richtung durch Bit 
	// des Tasters=0 gegeben ist
    ?

links_schieben:
    // TODO(1Zeile) Schieben um ein Bit nach Links
    ?

    // Vergleichen, ob der Wert mehr als 8 Bit hat / zu groß ist
    // TODO (3-4Zeilen): prüfe ob das Bit mit der 1 aus dem sichtbaren Bereich 
	// des Lauflichts geschoben wurde.  Gegebenenfalls das Muster zurückgesetzten
	?
	
dahinter:
    
    b ende_if       // überspringe den else-Zweig (=rechts)

rechts_schieben:
    // TODO(1Zeile) Schieben um ein Bit nach Links
    ?
    // Vergleichen, ob der Wert 0 ist und das Bit somit rausgeschoben wurde
    // TODO (3-4Zeilen): prüfe ob das Bit mit der 1 aus dem sichtbaren Bereich des Lauflichts geschoben wurde. 
	// gegebenenfalls muss das Muster zurückgesetzt werden
	?
	
dahinter2:

ende_if:


    // warten etwas damit das Lauflicht nicht zu schnell ist
    // wartezeit berechnen 
    ldr r4,=50000     // Basiswartezeit
    add r0, #1         // Mindestwartezeit setzen
    mul r4, r4, r0     // Wartezeit skalieren 
    // warteschleife
warten_durch_zaehlen:
    sub r4,#1           // ziehe 1 von R4 ab (r4--)
    cmp r4,#0           // vergleiche R4 mit Null   
    bge warten_durch_zaehlen     // springe zum Schleifenanfang, 
    
    b loop // Springe (branch) zum Label loop = Endlosschleife