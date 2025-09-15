# 🐾 Cuidapet — Sistema de Auto Atendimento

## 📌 Descripción
Este proyecto implementa un **sistema de autoatendimento en Dart** para la tienda de mascotas **Cuidapet**.  
Funciona por **consola** y permite a los clientes comprar productos o solicitar servicios de manera sencilla, aplicando reglas de negocio específicas (límite de ítems, descuentos, área restrita para empleados, etc.).

---

## ⚙️ Requisitos
- [Dart SDK 3.x](https://dart.dev/get-dart) instalado en el sistema.
- Consola/terminal (Windows, Linux o macOS).
- [Git](https://git-scm.com/) para clonar y manejar el proyecto.

---

## 🚀 Cómo ejecutar
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/TU-USUARIO/cuidapet.git
   cd cuidapet
2. Ejecutar el sistema
   ```bash
   dart run
   
## 🛍️ Funcionalidades principales

✅ Registro del nombre del cliente antes de iniciar la compra.
✅ Listado de productos en promoción (4 disponibles).
✅ Solicitud de servicios (3 disponibles).
✅ Carrito con límite máximo de 3 ítems.
✅ Pago con 10% de descuento si es en efectivo (dinheiro).
✅ Área restrita para empleados (contraseña: cuidapetrestrito) con registro manual de ventas.
✅ Resumen final del día: número de clientes atendidos y total facturado.

## 📂 Organización del proyecto
      ```bash
      cuidapet/
      │── bin/
      │   └── cuidapet.dart     # Código principal del sistema
      │── lib/                  # Código compartido (si se crean más clases)
      │── test/                 # Tests automáticos (pendientes)
      │── README.md             # Documentación principal
      │── .gitignore            # Archivos ignorados por Git
      │── pubspec.yaml          # Configuración del proyecto Dart


## 🌳 Flujo de ramas en Git

   main → rama principal estable.
   feature/... → ramas para nuevas funcionalidades.
   dev/... → rama opcional para integrar desarrollos.
   hotfix/... → correcciones rápidas en producción.
   docs/... → documentación (README, Wiki, etc.).


##📊 Ejemplo de ejecución

=== Bienvenido al sistema de Auto Atendimento Cuidapet 🐾 ===

Ingrese tu nombre (o ENTER para salir): Camilo


---- Menú principal ----
1. Ver promociones de productos
2. Solicitar servicios
3. Listar carrito
4. Finalizar carrito
5. Área restrita (empleados)
0. Cancelar y volver a inicio

Si el cliente finaliza compra con pago dinheiro, aparece:

Precio original: R$ 100.00
Se aplicó 10% de descuento por pago en efectivo.
Total a pagar: R$ 90.00
¡Pago registrado! Gracias por su compra, Camilo.

## 📘 Wiki (documentación técnica)

En la Wiki de GitHub se incluye:

Diagrama de Casos de Uso (UML).

Diagrama de Clases.

Paradigmas y decisiones técnicas adoptadas.

Registro de decisiones (ej. uso de OOP, manejo de carritos, descuentos).

Funcionalidades extras.


## ✨ Funcionalidades extra sugeridas

Generar recibo .txt al finalizar compra.

Registrar mascota (nombre/raza) asociada al cliente.

Sistema simple de fidelidad (acumular puntos).

## 👥 Créditos

Proyecto académico de Camilo Coronado
Lenguaje: Dart
Paradigma: Orientado a Objetos
