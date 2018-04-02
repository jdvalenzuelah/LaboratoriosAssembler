//Paquetes
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 * Clase Principal con implementacion de VectorHeap
 * @author Raul Monzon, 15014
 * @author David Valenzuela, 171001
 * @fecha 03/25/2018
 */
public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		 VectorHeap<Pacientes> vector = new VectorHeap<>();
		try {
			
			/*Abrimos el archivo de texto*/
			FileInputStream archivo = new FileInputStream("lista.txt");
			/*Objeto de entrada*/
			DataInputStream entrada = new DataInputStream(archivo);
			/*Buffer, que servira para lectura*/
			BufferedReader buffer = new BufferedReader(new InputStreamReader(entrada));
			/*Leer archivo*/
			String linea;
			while ((linea = buffer.readLine()) != null) {
				String[] temp = linea.split(", ");
                String nombre = temp[0];
                String descrip = temp[1];
                String code = temp[2];
                vector.add(new Pacientes(nombre, descrip, code));
            }
			
			entrada.close();
		
		} 
		catch (Exception e) {
			/*Mensaje de error*/
			System.err.println("Ocurrio un error " + e.getMessage());
		}
		
		boolean pass = true;
		while(pass) {
			System.out.println("Presione enter para obtener el siguiente paciente:");
			sc.nextLine();
			if(!vector.isEmpty()) {
				System.out.println(vector.remove().toString() + "\n");
			}else {
				System.out.println("Cola vacia!");
				pass = false;
			}
		}
		sc.close();
	}
}
