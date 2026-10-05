import 'package:go_router/go_router.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_inicio_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_servicios_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_asesoria_guiada_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_contacto_publica.dart';
import '../../caracteristicas/autenticacion/presentacion/pagina_login.dart';
import '../../caracteristicas/autenticacion/presentacion/pagina_registro.dart';
import '../../caracteristicas/cliente/presentacion/pagina_portal_cliente.dart';
import '../../caracteristicas/tecnico/presentacion/pagina_panel_tecnico.dart';
import '../../caracteristicas/administrador/presentacion/pagina_dashboard_admin.dart';
import '../presentacion/pagina_marcador.dart';

final enrutadorApp = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PaginaInicioPublica(),
    ),
    GoRoute(
      path: '/servicios',
      builder: (context, state) => const PaginaServiciosPublica(),
    ),
    GoRoute(
      path: '/solicitar-servicio',
      builder: (context, state) => const PaginaAsesoriaGuiadaPublica(),
    ),
    GoRoute(
      path: '/contacto',
      builder: (context, state) => const PaginaContactoPublica(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const PaginaLogin(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => const PaginaRegistro(),
    ),
    GoRoute(
      path: '/cliente',
      builder: (context, state) => const PaginaPortalClientePlaceholder(),
    ),
    GoRoute(
      path: '/tecnico',
      builder: (context, state) => const PaginaPanelTecnicoPlaceholder(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const PaginaDashboardAdminPlaceholder(),
    ),
  ],
  errorBuilder: (context, state) => const PaginaMarcador(
    titulo: '404 — Página no encontrada',
    subtitulo: 'La ruta especificada no existe en MIRASTEC.',
  ),
);
