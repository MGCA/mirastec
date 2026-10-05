import 'package:go_router/go_router.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_inicio_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_servicios_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_asesoria_guiada_publica.dart';
import '../../caracteristicas/inicio_publico/presentacion/pagina_contacto_publica.dart';
import '../../caracteristicas/autenticacion/presentacion/pagina_login.dart';
import '../../caracteristicas/autenticacion/presentacion/pagina_registro.dart';
import '../../caracteristicas/cliente/presentacion/pagina_portal_cliente.dart';
import '../../caracteristicas/cliente/presentacion/pagina_perfil_cliente.dart';
import '../../caracteristicas/equipos/presentacion/pagina_lista_equipos.dart';
import '../../caracteristicas/equipos/presentacion/pagina_formulario_equipo.dart';
import '../../caracteristicas/equipos/dominio/equipo_app.dart';
import '../../caracteristicas/tecnico/presentacion/pagina_panel_tecnico.dart';
import '../../caracteristicas/administrador/presentacion/pagina_dashboard_admin.dart';
import '../../caracteristicas/administrador/presentacion/pagina_configuracion_admin.dart';
import '../../caracteristicas/administrador/presentacion/pagina_gestion_servicios_admin.dart';
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
      builder: (context, state) => const PaginaPortalCliente(),
    ),
    GoRoute(
      path: '/cliente/perfil',
      builder: (context, state) => const PaginaPerfilCliente(clienteId: 'mi_id_cliente'),
    ),
    GoRoute(
      path: '/cliente/equipos',
      builder: (context, state) => const PaginaListaEquipos(clienteId: 'mi_id_cliente'),
    ),
    GoRoute(
      path: '/cliente/equipos/nuevo',
      builder: (context, state) {
        final equipo = state.extra as EquipoApp?;
        return PaginaFormularioEquipo(
          clienteId: 'mi_id_cliente',
          equipoEditar: equipo,
        );
      },
    ),
    GoRoute(
      path: '/tecnico',
      builder: (context, state) => const PaginaPanelTecnicoPlaceholder(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const PaginaDashboardAdmin(),
    ),
    GoRoute(
      path: '/admin/configuracion',
      builder: (context, state) => const PaginaConfiguracionAdmin(),
    ),
    GoRoute(
      path: '/admin/servicios',
      builder: (context, state) => const PaginaGestionServiciosAdmin(),
    ),
  ],
  errorBuilder: (context, state) => const PaginaMarcador(
    titulo: '404 — Página no encontrada',
    subtitulo: 'La ruta especificada no existe en MIRASTEC.',
  ),
);
