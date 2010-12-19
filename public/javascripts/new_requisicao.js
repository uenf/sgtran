function verificarObservacao() {
    var id = document.getElementById('requisicao_objetivo_de_reserva_id').options[document.getElementById('requisicao_objetivo_de_reserva_id').selectedIndex].id
    if (id.search(/nao_obrigatorio/)) {
        document.getElementById('observacao_label').className = 'obrigatorio'
        document.getElementById('aviso').className = 'visivel aviso'
    }
    else
    {
        document.getElementById('observacao_label').className = ''
        document.getElementById('aviso').className = 'invisivel'
    }
}

