int estado_boton = 1;
int presionado = false;
int estado_anterior = HIGH;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
}

void loop() {
  // lee HIGH porque esta en modo  INPUT_PULLUP
  int estado_actual = digitalRead(2); 

  // Si estado anterior es HIGH y estado actual es LOW entra
  if (estado_anterior == HIGH && estado_actual == LOW) {
    Serial.println(1);
  }
  estado_anterior = estado_actual;// Si está presionado es LOW
  delay(20);
}