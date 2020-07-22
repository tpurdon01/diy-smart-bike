#define DEBOUNCE_TIME 400

const int pinSwitch = 12; //Pin Reed
const int pinLed = 9; //Pin LED
int StatoSwitch = 0;
int last_pedal;
unsigned long pedal_time;

void setup() {

  pinMode(pinLed, OUTPUT);

  pinMode(pinSwitch, INPUT);

  Serial.begin(9600);

  last_pedal = LOW;
  pedal_time = 0;

}

void loop() {
  StatoSwitch = digitalRead(pinSwitch);

  if (StatoSwitch == HIGH)
  {
    unsigned long diff = millis() - pedal_time;
    if (diff > DEBOUNCE_TIME)
    {
      Serial.println("Pedal!");
      pedal_time = millis();
    }
    digitalWrite(pinLed, HIGH);
    last_pedal = StatoSwitch;
  }
  else
  {
    digitalWrite(pinLed, LOW);
  }

}
