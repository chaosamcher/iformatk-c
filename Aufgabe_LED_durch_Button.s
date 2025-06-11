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

LED_PIN = 5 // Pinnummer der LED auf dem Board an Port A Pin 5
USER_BUTTON_PIN= 13 // Pinnummer des Blauen Buttons auf dem Board an Port C Pin 13

// -------------- Code Section -----------------------------------------------------------------
.section .text // Bereich für Instruktionen (.data = Bereich für initialisierte Daten, .bss = uninitialisierte)
.global main // „main“ kann aus einem anderen File angesprungen werden (z.B. von startup_stm32f411xe.s)
// -------------- Hauptprogramm ----------------------------------------------------------------
main: 
    // aktiviere GPIO A-C
    ldr r1,=RCC // R1 = Adresse von rcc (siehe equ-Anweisung)
    ldr r2,[r1,#RCC_AHB1ENR] // R2 = Inhalt der Adrese[rcc+offset AVB1ENR]
    orr r2,#0x7 // setze die unteren 3 Bit von R2 auf ‚1‘
    str r2,[r1,#RCC_AHB1ENR] // Speicherzelle[RCC+offset AVB1ENR] = R2 
    
    // GPIOC ---- Teils Input Teils Output------------------------------
    ldr r1,=GPIOC // R1 = Basisadresse von Port C
    // Highbyte als Input, lower Byte als Output 
	// TODO: Ersetze die ? der nächsten Zeile um das Highbyte als Input und das Lowbyte als Output zu nutzen
    ldr r2,=0x???????? //   
	// TODO: Ersetze ? durch das #-Symbol und die Konstante für den Modus des Registers
    str r2,[r1,?] // 

    // GPIOA ------ LED an Port A auf dem Board als Output 
    ldr r1,=GPIOA // R1 = Basisadresse von Port A
	// TODO: Ersetze ? durch die Hexadezimal des Bitmusters mit einem Ausgang an der Stelle des LED-Pins
    ldr r2,=? // MODER_von_A = 00_00_00_00_00_00_00_00_00_00_01_00_00_00_00_00
    strh r2,[R1,#MODER] // Port A Modus

loop:       
    // lese den Userbutton
	// TODO: Ersetze ? um aus dem Port des Userbuttons lesen zu können
    ldr r1,=? // R1 = Basisadresse von Port C
	// TODO: Ersetze ? und ? mit dem Register mit der Basisadresse und dem Register um Daten einzulesen
    ldrh r2,[?,?] // R2 = Input von GPIOC
    // Das Bit des Userbuttons steht noch an Stelle 13, da der Button am 13. Pin angeschlossen ist

    // isoliere das Bit vom Userbutton
	// TODO ersetze ? und ? mit dem Befehl und der Konstanten um das Bit des Userbuttons an hinterste Stelle zu schieben
    ? r3, r2, ? // Schiebe das Bit des Userbuttons an die hinterste Stelle
	// TODO: ersetze ? mit dem Wert um alle Bits außer dem Hintersten auszumaskieren
    ands r3, ? // Bits ausmaskieren bis auf das hinterste Bit
    // nun gilt R3=0 wenn der Userbutton gedrückt ist und R3=1 wenn er nicht gedrückt ist

    // Button status auf LED ausgeben
	// TODO: ersetze ? und ? mit dem Befehl und der Konstanten um das hinterste Bit an die Stelle des LED Pins zu schieben
    ? r3, ? // schiebe das hinterste Bit, an die Stelle des LED Pins
    // gib nun R3 an Port A aus
    ldr r1,=GPIOA // R1 = Basisadresse von Port A
	// TODO ersetze ? mit der Konstanten um das Bitmuster von R3 am Port auszugeben
    strh r3,[r1,?] // Ausgabe Inhalt von R3 auf GPIOA
	
	// TODO erseze ? mit der Sprungmarke, sodass der Code endlos läuft, die Grundeinstellung aber nur einmal gemacht wird
    b ? // Springe für eine Endlosschleife
