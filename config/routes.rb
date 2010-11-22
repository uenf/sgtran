ActionController::Routing::Routes.draw do |map|

  map.resources :cidades
  map.resources :estados
  map.resources :prefixos
  map.resources :bdts
  map.resources :centros
  map.resources :objetivos_de_reserva
  map.resources :motivos
  map.resources :usuario_sessions
  map.resources :usuarios
  map.resources :veiculos
  map.resources :combustiveis
  map.resources :categoria_de_veiculos
  map.resources :veiculos
  map.resources :solicitantes
  map.resources :viagens
  map.resources :requisicoes
  map.resources :configuracoes, :only => [:edit, :update]


  # Outras rotas
  map.root :controller => "requisicoes", :action => "new"
  map.admin "/admin", :controller => "usuario_sessions", :action => "new"
  map.sair "/sair", :controller => "usuario_sessions", :action => "destroy"
  map.base_de_dados "base_de_dados", :controller => "sistema", :action => "base_de_dados"
  map.relatorios "relatorios", :controller => "sistema", :action => "relatorios"

  # Rotas para requisições
  map.aceitar "/requisicoes/:id/aceitar", :controller => "requisicoes", :action => "aceitar"
  map.rejeitar "requisicoes/rejeitar/:id", :controller => "requisicoes", :action => "rejeitar"
  map.requisicoes_new "/requisicoes/new", :controller => "requisicoes", :action => "new"
  map.confirmar_requisicao "confirmar_requisicao", :controller => "requisicoes", :action => "confirmar_requisicao"
  map.cancelar_requisicao "requisicoes/cancelar/:id/:chave_de_seguranca", :controller => "requisicoes", :action => "cancelar_requisicao"
  map.cancelar_requisicao_pelo_sistema "requisicoes/:id/cancelar_requisicao_pelo_sistema", :controller => "requisicoes", :action => "cancelar_requisicao_pelo_sistema"
  map.cancelar_pelo_sistema "requisicoes/cancelar_pelo_sistema", :controller => "requisicoes", :action => "cancelar_pelo_sistema"
  map.rejeitar_requisicao "rejeitar_requisicao", :controller => "requisicoes", :action => "rejeitar_requisicao"
  map.imprimir_requisicao "imprimir", :controller => "requisicoes", :action => "imprimir_requisicao"
  map.visualizar_requisicao "requisicoes/visualizar/:id/:chave_de_seguranca", :controller => "requisicoes", :action => "visualizar_requisicao"
  map.filtrar_requisicao "/filtrar_requisicao", :controller => "requisicoes", :action => "filtrar"
  map.admin_requisicao "/nova_requisicao", :controller => "requisicoes", :action => "new_admin"

  # Rotas para viagens
  map.viagem "viagem/show/:id", :controller => "viagens", :action => "show"
  map.aceitar_viagem "requisicoes/:id/aceitar", :controller => "requisicoes", :action => "aceitar"
  map.filtrar_viagem "filtrar_viagem", :controller => "viagens", :action => "filtrar"
  map.cancelar_viagem "viagens/:id/cancelar_viagem", :controller => "viagens", :action => "cancelar_viagem"
  map.cancelamento_da_viagem "viagens/cancelamento_da_viagem", :controller => "viagens", :action => "cancelamento_da_viagem"
  map.fechar_viagem "viagens/:id/bdt/", :controller => "bdts", :action => "new"
  map.viagens_sem_bdt "viagens_sem_bdt", :controller => "viagens", :action => "viagens_sem_bdt"

  # Rotas para solicitantes
  map.ativar_solicitante "solicitantes/ativacao/:id", :controller => "solicitantes", :action => "ativar_solicitante"
  map.desativar_solicitante "solicitantes/desativacao/:id", :controller => "solicitantes", :action => "desativar_solicitante"

  # Rotas para motoristas
  map.vencimento_cnh "motoristas/vencimento_cnh", :controller => "motoristas", :action => "vencimento_cnh"
  map.ativar_motorista "motoristas/ativacao/:id", :controller => "motoristas", :action => "ativar_motorista"
  map.desativar_motorista "motoristas/desativacao/:id", :controller => "motoristas", :action => "desativar_motorista"
  map.resources :motoristas

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # Rota para páginas não encontradas (erro 404).
  # Esta deve ser aúltima linha deste arquivo.
  map.connect '*path', :controller => :application, :action => :render_404
end

