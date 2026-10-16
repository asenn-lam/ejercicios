import processing.serial.*;
import oscP5.*;
import netP5.*;

Serial puerto;
OscP5 osc;
NetAddress servidor;

// ---- CONFIGURACIÓN ----
String IP_SERVIDOR = "127.0.0.1";  // Verificar IP servidor
int PUERTO_OSC     = 12000;        // Verificar PUERTO servidor
String ID_PC       = "pc1";        // Identificador de mi compu para que el servidor sepa quien es
// ------------------------

int valor = 0;

void setup() {
  size(400, 200);

  println(Serial.list());  // Imprime en consola los puertos disponibles

  // Configuracion estandar para lectura del puerto serial Arduino
  puerto = new Serial(this, Serial.list()[0], 9600);  // cambiar el índice si hace falta
  // cuando arduino envía "println", el "ln" es nueva linea, por ende agrega al final del dato \n
  // En este caso se detecta el \n para separar los mensaje y saber que son mensajes diferentes.
  puerto.bufferUntil('\n');

  osc = new OscP5(this, 12001);  // 12001 -> puerto local (no se usa para recibir, pero se deja configurado)
  // Ubicación de la compu que recibe los datos (servidor)
  servidor = new NetAddress(IP_SERVIDOR, PUERTO_OSC);
}

void draw() {
  background(0);
}
void serialEvent(Serial p) {
  // Ver si es un valor seguido o uno por vez?

  String linea = p.readStringUntil('\n');
  if (linea == null) return;
  try {
    valor = Integer.parseInt(trim(linea));
    println(valor);// Para ve en consola el dato que entra
  }
  catch (NumberFormatException e) {
    return;  // ignora líneas corruptas
  }
  // Podemos jugar con valor para dar distintas funcionalidades, enviando distintos mensajes
  if (valor == 1) {
    OscMessage msg = new OscMessage("/sensor"); // "/sensor" el la ruta OSC
    msg.add(ID_PC);   // quién lo manda
    osc.send(msg, servidor); // Se envia al servidor
  }
}
