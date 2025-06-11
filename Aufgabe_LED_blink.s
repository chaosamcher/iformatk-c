.syntax unified // es wird die neueste Syntax 
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

ON_COUNTER_TARGET = 500000 // Zähler Zielwert solange die LED an ist
OFF_COUNTER_TARGET = 500000 // Zähler Zielwert solange die LED aus ist

// -------------- Code Section -----------------------------------------------------------------
.section .text // Bereich für Instruktionen (.data = Bereich für initialisierte Daten, .bss = uninitialisierte)
.global main // main kann aus einem anderen File angesprungen werden (z.B. von startup_stm32f411xe.s)
// -------------- Hauptprogramm ----------------------------------------------------------------
main: 
    // aktiviere GPIO A-C
    ldr r1,=RCC // R1 = Adresse von rcc (siehe equ-Anweisung)
    ldr r2,[r1,#RCC_AHB1ENR] // R2 = Inhalt der Adrese[rcc+offset AVB1ENR]
    orr r2,#0x7 // setze die unteren 3 Bit von R2 auf 1
    str r2,[r1,#RCC_AHB1ENR] // Speicherzelle[RCC+offset AVB1ENR] = R2 
    
    // GPIOA ------ LED an Port A auf dem Board als Output 
    ldr r1,=GPIOA // R1 = Basisadresse von Port A
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
	? // MODER_von_A = 00_00_00_00_00_00_00_00_00_00_01_00_00_00_00_00
	// TODO: ersetze ? durch die Offsetadresse des passenden Registers
    strh r2,[R1,#?] // Port A Modus setzen

loop:    
    // LED einschalten
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ? // R1 = Basisadresse von Port A
	// TODO: ersetze ? mit einer Binärzahl, die nur Nullen hat außer an letzer Stelle
    mov r2, ? // speichere eine 1 an letzter Stelle
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ? // schiebe die 1 an die Stelle des LED Pins	
	// TODO: ersetze ? und ? durch das passende Register und der passenden Offsetadresse
    strh ?,[r1,#?] // Ausgabe Inhalt von R2 (Bit für LED ein) auf GPIOA
    // Zähler einstellen
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
	? // counter in r4 auf 0 setzen
	// TODO: ersetze ? durch die Konstante für den Zähler Zielwert
    ldr r5, =? // Zielwert für Zähler laden
on_counter: // für aktives Warten der Zeit in der die LED an sein soll
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ? // counter erhöhen
	// TODO: ersetze ? und ? durch das Register mit dem Zählerstand und das Register für den Zielwert
    cmp ?, ? // vergleiche den Zähler mit dem Zielwert des Zählers
	// TODO: ersetze ? durch den richtigen bedingten Sprungbefehl
    ? on_counter // springe zur marke 'on_counter' wenn Zielwert noch nicht erreicht


    // LED ausschalten
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ? // R1 = Basisadresse von Port A
    mov r2, #0 // setze alle Bits auf 0
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ? // Ausgabe Inhalt von R2 für LED auf GPIOA
    // Zähler einstellen
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
	? // counter in r4 auf 0 setzen
    ldr r5, =OFF_COUNTER_TARGET // Zielwert für Zähler laden
off_counter: // für aktives Warten der Zeit in der die LED aus sein soll
    add r4, 1 // counter erhöhen
	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
    ?// vergleiche den Zähler mit dem Zielwert des Zählers
    // TODO: ersetze ? durch den richtigen bedingten Sprungbefehl
    ? off_counter // springe zur marke 'off_counter' wenn Zielwert noch nicht erreicht

	// TODO: ersetze ? durch den Befehl, der sich durch den Kommentar ergibt
	? // Springe unbedingt zum Label loop für eine Endlosschleife
