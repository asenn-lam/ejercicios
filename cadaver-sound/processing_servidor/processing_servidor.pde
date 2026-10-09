import oscP5.*;
import netP5.*;
import processing.sound.*;
import java.util.Map;

// Note the HashMap's "key" is a String and "value" is an Integer

OscP5 osc;

// ---- CONFIGURACIÓN ----
int PUERTO_OSC = 12000;        // Puerto de escucha -> el cliente debe enviar a este puerto con la IP de esta maquina
String[] IDS   = { "pc1" }; // Identificadores de PCs
// ------------------------

// Se define un Mapa para almacenar los sonidos
HashMap<String, SoundFile> sonidos = new HashMap<String, SoundFile>();
void setup() {
  size(450, 300);

  // Carga todos los sonidos
  for (int i = 0; i < IDS.length; i++) {
    // En el nombre de archivo combina el IDS con la extension -> pc1.acc
    SoundFile sonido = new SoundFile(this, IDS[i] + ".wav");
    sonidos.put(IDS[i], sonido);
  }

  // Inicializa protocolo OSC
  osc = new OscP5(this, PUERTO_OSC);
  println("Servidor escuchando en el puerto " + PUERTO_OSC);
}

void draw() {
  background(0);
}

void oscEvent(OscMessage msg) {
  if (!msg.checkAddrPattern("/sensor")) return;

  String id = msg.get(0).stringValue();
  SoundFile sonido = sonidos.get(id);
  float duracion = sonido.duration();
  println(sonido);
  sonido.stop();
  sonido.play();
  //sonido.jump(duracion * random(1.0));
  //if(sonido != null){
  //}
}
