# Aula 18: Relacionamentos e mapeamentos

# -----------------------------------------------------------------



db.editora.insertOne( 

   {nome: "Mágica", 

    cidade: "João Pessoa"} )

    

db.livro.insertOne(

    {title:"Testando Refs entre coleções",     

    url:"http://www.mongodbexpert.com",

  editora:ObjectId("647dd353a614046c11d60fad")})

  

  

# Fazendo consulta com duas coleções relacionadas 



db.livro.aggregate([

{$lookup:

    {

        from: "editora",

        localField: "editora",

        foreignField : "_id",

        as: "Editora do livro"

    }

},

{$match:

    {"Editora do livro.cidade":"João Pessoa"}

}

])



# Inserindo e estruturando relacionamentos 



db.livro.insertOne( 

   {titulo:"Sistemas de Bancos de Dados", 

    palavras_chave:["SGBD","relacional","NoSQL"], 

    ano: 2017,

    gênero: ["Computação","Projeto"], 

    notaMédia: 4.0 

   })

   

db.livro.insertOne( 

   {titulo:"Projeto de Banco de Dados", 

    palavras_chave:["SGBD","relacional"], 

    ano: 2015,

    gênero: ["Computação","Projeto"], 

    notaMédia: 4.0,

    editora: "Pearson",

    autor: [

       {nome:"Carlos Heuser", email: "ch@example.com"},

       {nome:"Carlos Heuser Jr", email: "chj@example.com"}

       ]

   }) 

   

 db.autor.insert (

   {nome: "Carlos Heuser ",

    email: "ch@example.com", 

    livro: [

      {num:1, titulo:"Projeto de Banco de Dados"},

      {num:2, titulo:"Projeto de NoSQL"}      

   ]})



db.livro.insertOne( 

   {título:"Conde de Monte Cristo2", 

    numpags: 1663,

    ano: 2012,

    palavraschave:["revolução","vingança"], 

    gênero: ["drama", "literatura"],

    notamedia: 4,     

    editora: "Zahar",

    autor: [

        {"01": ObjectId("647dd970a614046c11d60faf")    }]}) 

        

 

 db.autor.insert (

   {nome: "Joana Brandão ",

    email: "jb@example.com", 

    livro: [

      {num:1, titulo:"Projeto de Banco NoSQL"}],

    beneficio: 1.000,

    instituição: "IFPB"  

})



db.autor.insert (

   {nome: "Mariana Chaves ",

    email: "mc@example.com", 

    livro: [

      {num:1, titulo:"Projeto de Banco NoSQL"}],

    empresa: "XXXX"  

      })