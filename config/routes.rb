ActionController::Routing::Routes.draw do |map|
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
  map.resources :motoristas
  map.resources :viagens
  map.aceitar "/requisicoes/:id/aceitar", :controller => "requisicoes", :action => "aceitar"
  map.viagem "viagem/show/:id", :controller => "viagens", :action => "show"

  map.requisicoes_new "/requisicoes/new", :controller => "requisicoes", :action => "new"
  map.root :controller => "requisicoes", :action => "new"
  map.confirmar_requisicao "confirmar_requisicao", :controller => "requisicoes", :action => "confirmar_requisicao"
  map.imprimir_requisicao "imprimir", :controller => "requisicoes", :action => "imprimir_requisicao"
  map.cancelar_requisicao "requisicoes/cancelar/:id/:chave_de_seguranca", :controller => "requisicoes", :action => "cancelar_requisicao"
  map.visualizar_requisicao "requisicoes/visualizar/:id/:chave_de_seguranca", :controller => "requisicoes", :action => "visualizar_requisicao"
  map.aceitar_viagem "requisicoes/:id/aceitar", :controller => "requisicoes", :action => "aceitar"
  map.cancelar_requisicao_pelo_sistema "requisicoes/:id/cancelar_requisicao_pelo_sistema", :controller => "requisicoes", :action => "cancelar_requisicao_pelo_sistema"
  map.rejeitar "requisicoes/rejeitar/:id", :controller => "requisicoes", :action => "rejeitar"

  map.resources :requisicoes

  map.admin "/admin", :controller => "usuario_sessions", :action => "new"
  map.sair "/sair", :controller => "usuario_sessions", :action => "destroy"

  map.filtrar_requisicao "/filtrar_requisicao", :controller => "requisicoes", :action => "filtrar"

  map.filtrar_viagem "filtrar_viagem", :controller => "viagens", :action => "filtrar"

  map.rejeitar_requisicao "rejeitar_requisicao", :controller => "requisicoes", :action => "rejeitar_requisicao"

  map.cancelar_pelo_sistema "requisicoes/cancelar_pelo_sistema", :controller => "requisicoes", :action => "cancelar_pelo_sistema"

  map.base_de_dados "base_de_dados", :controller => "requisicoes", :action => "base_de_dados"

  map.cancelar_viagem "viagens/:id/cancelar_viagem", :controller => "viagens", :action => "cancelar_viagem"
  map.cancelamento_da_viagem "viagens/cancelamento_da_viagem", :controller => "viagens", :action => "cancelamento_da_viagem"
  
  map.fechar_viagem "viagens/fechar_viagem/:id", :controller => "viagens", :action => "fechar_viagem"
  
  map.alterar_viagem "requisicoes/alterar_viagem/:id", :controller => "requisicoes", :action => "alterar_viagem"


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # Essa linha faz a rota para páginas não encontradas (erro 404) e deve ser a
  # última linha deste arquivo.
  map.connect '*path', :controller => :application, :action => :render_404
end

