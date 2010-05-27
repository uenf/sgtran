function busca(campo) 
{
    if (campo.value == "Data") 
    {
        document.getElementById("box_nome").className = 'invisivel'        
        document.getElementById("box_data").className = 'visivel'
    }
    else if (campo.value == "Nome")
    {
        document.getElementById("box_nome").className = 'visivel'
        document.getElementById("box_data").className = 'invisivel'
    }
    else
    {
        document.getElementById("box_nome").className = 'invisivel'
        document.getElementById("box_data").className = 'invisivel'        
    }
}
