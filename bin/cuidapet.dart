import 'dart:io';

class Item {
  final String code;
  final String name;
  final double price;
  final bool isService;

  Item(this.code, this.name, this.price, {this.isService = false});

  @override
  String toString() => '$code - $name: R\$ ${price.toStringAsFixed(2)}';
}

class Cart {
  final List<Item> items = [];
  final int maxItems;

  Cart({this.maxItems = 3});

  bool addItem(Item item) {
    if (items.length >= maxItems) return false;
    items.add(item);
    return true;
  }

  double total() => items.fold(0.0, (s, i) => s + i.price);

  void clear() => items.clear();

  bool isEmpty() => items.isEmpty;

  void listItems() {
    if (items.isEmpty) {
      print('El carrito está vacío.');
      return;
    }
    for (var i = 0; i < items.length; i++) {
      print('${i + 1}. ${items[i]}');
    }
    print('Total parcial: R\$ ${total().toStringAsFixed(2)}');
  }
}

class SessionManager {
  int totalClients = 0;
  double totalRevenue = 0.0;

  void registerSale(double value) {
    totalClients++;
    totalRevenue += value;
  }

  void summary() {
    print('\n--- Resumen del día ---');
    print('Clientes atendidos: $totalClients');
    print('Valor total facturado: R\$ ${totalRevenue.toStringAsFixed(2)}');
  }
}

String readLine({String prompt = ''}) {
  if (prompt.isNotEmpty) stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

void pause() {
  print('\nPresiona Enter para continuar...');
  stdin.readLineSync();
}

void main() {
  final products = <Item>[
    Item('P01', 'Ração Premium 1kg', 49.90),
    Item('P02', 'Ração Adulto 5kg', 129.90),
    Item('P03', 'Brinquedo Interativo', 39.50),
    Item('P04', 'Coleira Ajustável', 24.99),
  ];

  final services = <Item>[
    Item('S01', 'Banho Simples', 40.00, isService: true),
    Item('S02', 'Tosa Higiênica', 60.00, isService: true),
    Item('S03', 'Corte de Unhas', 20.00, isService: true),
  ];

  final session = SessionManager();

  print('=== Bienvenido al sistema de Auto Atendimento Cuidapet ===');

  bool running = true;
  while (running) {
    String clientName = readLine(prompt: '\nIngrese tu nombre (o ENTER para salir): ');
    if (clientName.trim().isEmpty) {
      print('Saliendo del sistema...');
      session.summary();
      break;
    }

    print('\nHola, $clientName! Bienvenido/a.');
    final cart = Cart();
    bool clientSession = true;

    while (clientSession) {
      print('\n---- Menú principal ----');
      print('1. Ver promociones de productos');
      print('2. Solicitar servicios');
      print('3. Listar carrito');
      print('4. Finalizar carrito');
      print('5. Área restrita (empleados)');
      print('0. Cancelar y volver a inicio');
      var opt = readLine(prompt: 'Elija una opción: ').trim();

      switch (opt) {
        case '1':
          print('\n--- Productos en promoción ---');
          for (var p in products) print(p);
          var code = readLine(prompt: '\nIngrese el código del producto para añadir (o ENTER para volver): ').toUpperCase();
          if (code.isNotEmpty) {
            var found = products.firstWhere((e) => e.code == code, orElse: () => Item('', '', 0.0));
            if (found.code == '') {
              print('Código inválido.');
            } else {
              if (cart.addItem(found)) {
                print('Producto añadido: ${found.name}');
              } else {
                print('No se pueden añadir más items (límite ${cart.maxItems}).');
              }
            }
          }
          break;

        case '2':
          print('\n--- Servicios ---');
          for (var s in services) print(s);
          var codeS = readLine(prompt: '\nIngrese el código del servicio para añadir (o ENTER para volver): ').toUpperCase();
          if (codeS.isNotEmpty) {
            var foundS = services.firstWhere((e) => e.code == codeS, orElse: () => Item('', '', 0.0));
            if (foundS.code == '') {
              print('Código inválido.');
            } else {
              if (cart.addItem(foundS)) {
                print('Servicio añadido: ${foundS.name}');
              } else {
                print('No se pueden añadir más items (límite ${cart.maxItems}).');
              }
            }
          }
          break;

        case '3':
          print('\n--- Carrito ---');
          cart.listItems();
          pause();
          break;

        case '4':
          if (cart.isEmpty()) {
            print('El carrito está vacío, no hay nada para finalizar.');
            break;
          }
          cart.listItems();
          var payment = readLine(prompt: '\nIngrese forma de pago (dinheiro/cartao/pix): ').toLowerCase();
          double total = cart.total();
          bool isCash = (payment == 'dinheiro' || payment == 'dinero' || payment == 'efectivo' || payment == 'cash');
          if (isCash) {
            print('Precio original: R\$ ${total.toStringAsFixed(2)}');
            total = total * 0.90; // 10% de desconto
            print('Se aplicó 10% de descuento por pago en efectivo.');
          }
          print('Total a pagar: R\$ ${total.toStringAsFixed(2)}');
          session.registerSale(total);
          print('¡Pago registrado! Gracias por su compra, $clientName.');
          cart.clear();
          clientSession = false; // termina la sesión del cliente y vuelve para otro nombre
          break;

        case '5':
          // Área restrita
          var pass = readLine(prompt: 'Ingrese la contraseña de área restrita: ');
          if (pass == 'cuidapetrestrito') {
            print('\n--- Área de empleados ---');
            var inputName = readLine(prompt: 'Nombre del cliente (o ENTER para cancelar): ');
            if (inputName.trim().isEmpty) {
              print('Operación cancelada.');
            } else {
              var valueStr = readLine(prompt: 'Valor de la compra (R\$): ');
              double value = double.tryParse(valueStr.replaceAll(',', '.')) ?? -1;
              if (value <= 0) {
                print('Valor inválido.');
              } else {
                var pay = readLine(prompt: 'Forma de pago (dinheiro/cartao/pix): ').toLowerCase();
                bool cash = (pay == 'dinheiro' || pay == 'dinero' || pay == 'efectivo' || pay == 'cash');
                if (cash) {
                  value = value * 0.90;
                  print('Descuento de 10% aplicado. Valor final: R\$ ${value.toStringAsFixed(2)}');
                }
                session.registerSale(value);
                print('Venta registrada manualmente por el empleado.');
              }
            }
          } else {
            print('Contraseña incorrecta.');
          }
          pause();
          break;

        case '0':
          print('Cancelando sesión del cliente y volviendo al inicio...');
          clientSession = false;
          break;

        default:
          print('Opción inválida. Intente nuevamente.');
      }
    }
  }
}

