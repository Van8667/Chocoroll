    import tkinter as tk
    from tkinter import filedialog, messagebox, scrolledtext

    # Mapeo de operaciones a sus códigos binarios
    alu_codes = {
        'suma': '010',
        'resta': '110',
        'and': '000',
        'or': '001',
        'nor': '100',
        'moverq': '111',
        'leer': '000',  # Código de operación para leer (opcional)
    }

    # Variable para almacenar el contenido del archivo
    contenido_archivo = ""


    def seleccionar_archivo():
        """Abre un cuadro de diálogo para seleccionar un archivo y lo carga."""
        global contenido_archivo  # Usar la variable global
        archivo = filedialog.askopenfilename(title="Seleccionar archivo",
                                             filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
        if archivo:
            with open(archivo, 'r') as f:
                contenido_archivo = f.read()
            # Mostrar el contenido en el área de texto
            txt_contenido.delete(1.0, tk.END)  # Limpiar el área de texto
            txt_contenido.insert(tk.END, contenido_archivo)  # Insertar el contenido
            messagebox.showinfo("Archivo Cargado", "Archivo seleccionado con éxito. Ahora puedes decodificar.")


    def decodificar_a_binario():
        """Convierte el contenido a un formato binario específico y lo guarda en un nuevo archivo."""
        global contenido_archivo  # Usar la variable global
        if not contenido_archivo:
            messagebox.showwarning("Advertencia", "No se ha seleccionado ningún archivo.")
            return

        try:
            lineas_binarias = []

            for linea in contenido_archivo.splitlines():
                if linea.strip():  # Solo procesar líneas no vacías
                    partes = linea.split()
                    instruccion = partes[0]

                    # Verificar que hay suficientes partes
                    if len(partes) < 4:
                        messagebox.showwarning("Advertencia", f"Línea incompleta: '{linea}'. Se omitirá esta línea.")
                        continue  # Omitir líneas incompletas

                    # Determinar el valor de 'we'
                    if instruccion == 'leer':
                        we = '00'
                    else:
                        we = '01'  # Para escribir

                    # Convertir a binario (5 bits), asegurando que se está accediendo a los índices correctos
                    operando1 = format(int(partes[1][1:]), '05b')  # Convertir a binario (5 bits)
                    operando2 = format(int(partes[2][1:]), '05b')  # Convertir a binario (5 bits)
                    lugar_guardar = format(int(partes[3][1:]), '05b')  # Convertir a binario (5 bits)

                    if instruccion in alu_codes:
                        alu = alu_codes[instruccion]
                        # Formatear la línea
                        linea_binaria = f"{we} {operando1} {alu} {operando2} {lugar_guardar}"
                        lineas_binarias.append(linea_binaria)

            # Abrir un cuadro de diálogo para seleccionar dónde guardar el archivo
            archivo_guardar = filedialog.asksaveasfilename(title="Guardar archivo como", defaultextension=".txt",
                                                           filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
            if archivo_guardar:
                # Guardar los resultados en el archivo seleccionado
                with open(archivo_guardar, 'w') as f:
                    f.write('\n'.join(lineas_binarias))

                messagebox.showinfo("Éxito", f"El contenido se ha decodificado y guardado en '{archivo_guardar}'")
        except Exception as e:
            messagebox.showerror("Error", f"Ocurrió un error: {e}")


    def salir():
        """Cierra la aplicación."""
        root.quit()


    # Configuración de la ventana principal
    root = tk.Tk()
    root.title("Decodificador de Instrucciones")
    root.geometry("500x400")

    # Crear botones
    btn_seleccionar = tk.Button(root, text="Seleccionar Archivo", command=seleccionar_archivo)
    btn_seleccionar.pack(pady=10)

    btn_decodificar = tk.Button(root, text="Decodificar", command=decodificar_a_binario)
    btn_decodificar.pack(pady=10)

    btn_salir = tk.Button(root, text="Salir", command=salir)
    btn_salir.pack(pady=10)

    # Crear un área de texto para mostrar el contenido del archivo
    txt_contenido = scrolledtext.ScrolledText(root, width=60, height=15)
    txt_contenido.pack(pady=10)

    # Iniciar el bucle principal
    root.mainloop()
