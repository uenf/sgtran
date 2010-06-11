function busca(campo)
{
    if (campo.value == "Data")
    {
        document.getElementById("box_nome").className = 'invisivel'
        document.getElementById("box_protocolo").className = 'invisivel'
        document.getElementById("box_data").className = 'visivel'
    }
    else if (campo.value == "Nome")
    {
        document.getElementById("box_nome").className = 'visivel'
        document.getElementById("box_data").className = 'invisivel'
        document.getElementById("box_protocolo").className = 'invisivel'
    }
    else if (campo.value == "Protocolo")
    {
        document.getElementById("box_nome").className = 'invisivel'
        document.getElementById("box_data").className = 'invisivel'
        document.getElementById("box_protocolo").className = 'visivel'
    }
    else
    {
        document.getElementById("box_nome").className = 'invisivel'
        document.getElementById("box_data").className = 'invisivel'
        document.getElementById("box_protocolo").className = 'visivel'
    }
}

function busca_viagem(campo)
{
    if (campo.value == "Data de partida")
    {
        document.getElementById("box_data_de_partida").className = 'visivel'
        document.getElementById("box_data_de_chegada").className = 'invisivel'
        document.getElementById("box_motorista").className = 'invisivel'
        document.getElementById("box_placa").className = 'invisivel'
    }
    else if (campo.value == "Data de chegada")
    {
        document.getElementById("box_data_de_partida").className = 'invisivel'
        document.getElementById("box_data_de_chegada").className = 'visivel'
        document.getElementById("box_motorista").className = 'invisivel'
        document.getElementById("box_placa").className = 'invisivel'        
    }
    else if (campo.value == "Motorista")
    {
        document.getElementById("box_data_de_partida").className = 'invisivel'
        document.getElementById("box_data_de_chegada").className = 'invisivel'
        document.getElementById("box_motorista").className = 'visivel'
        document.getElementById("box_placa").className = 'invisivel'        
    }
    else if (campo.value == "Placa")
    {
        document.getElementById("box_data_de_partida").className = 'invisivel'
        document.getElementById("box_data_de_chegada").className = 'invisivel'
        document.getElementById("box_motorista").className = 'invisivel'
        document.getElementById("box_placa").className = 'visivel'          
    }
    else
    {
        document.getElementById("box_data_de_partida").className = 'invisivel'
        document.getElementById("box_data_de_chegada").className = 'invisivel'
        document.getElementById("box_motorista").className = 'invisivel'
        document.getElementById("box_placa").className = 'invisivel'        
    }
}

