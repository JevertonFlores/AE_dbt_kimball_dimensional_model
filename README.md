# Kimball Dimensional Model with dbt (data build tool)
Repositório para armazenamento e versionamento de código de projeto pessoal de modelagem de dados utilizando a ferramenta dbt.

<h3>Objetivo:</h3>
Este projeto tem como objetivo praticar o desenvolvimento utilizando o dbt, criando um modelo dimensional (Star Schema), com dados fictícios sobre vendas de produtos e serviços automotivos.

<h3>Ferramentas e liguagens utilizadas:</h3>

- Ambiente virtual em Python;
- Mockaroo (https://www.mockaroo.com/) para gerar bases de dados fictícias;
- PostgreSQL como source e também como solução de DW;
- BR Modelo para criação da Modelagem Lógica;
- dbt (data build tool) e SQL para o tratamento e modelagem dos dados.

<h3>Origem dos dados:</h3>
Os dados foram gerados através do site Mockaroo e exportados em arquivos .csv que posteriormente foram gravados em um banco de dados PostgreSQL.  

Como se tratam de dados fictícios e gerados aleatóriamente, os valores finais não são levados em consideração, pois nem sempre fazem sentido, porém isso não afeta o objetivo do projeto que é praticar no dbt e desenvolver um modelo dimensional.


<h3>###########################################################</h3>

<h3>Projeto BI - CAR SALES</h3>

<h3>Objetivos:</h3>

1. Análise de Desempenho  
	a. Venda de veículos  
	b. Revisões técnicas  
	c. Manutenções preventivas  
	d. Venda de produtos da loja  
2. Tempo Médio de Atendimento


<h3>Modelagem Lógica:</h3>  

![image](https://github.com/JevertonFlores/AE_dbt_kimball_dimensional_model/assets/36814309/9f19336b-2175-432d-8215-961aed86b766)  


<h3>Recursos do projeto:</h3>  

<a href="https://github.com/JevertonFlores/AE_dbt_kimball_dimensional_model/tree/main/data">- Files .csv</a>  

<a href="https://github.com/JevertonFlores/AE_dbt_kimball_dimensional_model/tree/main/models">- Models</a>  

- Source
  - Staging
  - Intermediate
  - Marts
 
PS: A tabela dimensão dim_dates foi criada diretamenta no banco de dados, todas as demais tabelas se encontram dentro de Models.  


<h3>Lineage:</h3> 

![image](https://github.com/JevertonFlores/AE_dbt_kimball_dimensional_model/assets/36814309/bebcc38d-0b57-499f-8db1-2fd11b5910fd) 



<h3>Schemas e tabelas no Banco de Dados:</h3>  

![image](https://github.com/JevertonFlores/AE_dbt_kimball_dimensional_model/assets/36814309/e1fcab4c-ae66-4582-9078-bb3ba4a19a33)



<h3>Próximas atualizações:</h3> 

- Instalação do package dbt-utils;
- Criação de testes de qualidade nas dimensões e fato.

  

