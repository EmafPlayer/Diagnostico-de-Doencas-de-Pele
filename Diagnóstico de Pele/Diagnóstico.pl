%Criação das tuplas de sintomas que estão "indexadas" pelo número a qual estão acompanhadas
sintoma(1,'Coceira').
sintoma(2,'Manchas Vermelhas').
sintoma(3,'Espinhas').
sintoma(4,'Pele Ressecada').
sintoma(5,'Vermelhidão').
sintoma(6,'Erupções Cutâneas').
sintoma(7,'Descamação').
sintoma(8,'Escamas Secas Esbranquiçadas').
sintoma(9,'Feridas Avermelhadas').
sintoma(10,'Bolhas com Pus').
sintoma(11,'Pápulas').
sintoma(12,'Cravos').
sintoma(13,'Manchas Escuras na Pele').
sintoma(14,'Queimação').
sintoma(15,'Manchas Brancas').
sintoma(16,'Deformação nas Unhas').
sintoma(17,'Rachaduras Entre os Dedos').
sintoma(18,'Inflamação da Pele').
sintoma(19,'Manchas que Coçam').
sintoma(20,'Feridas que não Cicatrizam').
sintoma(21,'Pintas que Mudam de Mamanho e de Cor').

%Criação das listas de doenças, onde as cabeças são o nome das doenças e corpo os seus sintomas
doenca(['Acne','Cravos','Pápulas','Espinhas']).
doenca(['Rosácea','Erupções Cutâneas','Espinhas','Manchas Vermelhas','Coceira']).
doenca(['Impetigo','Bolhas com Pus','Feridas Avermelhadas','Espinhas','Manchas Vermelhas','Coceira']).
doenca(['Melasma','Manchas Escuras na Pele']).
doenca(['Psoríase','Queimação','Escamas Secas Esbranquiçadas','Pele Ressecada','Manchas Vermelhas','Coceira']).
doenca(['Micose','Inflamação da Pele','Rachaduras Entre os Dedos','Deformação nas Unhas','Manchas Brancas','Vermelhidão','Coceira']).
doenca(['Dermatite Atópica','Descamação','Erupções Cutâneas','Vermelhidão','Pele Ressecada','Coceira']).
doenca(['Câncer de Pele','Pintas que Mudam de Mamanho e de Cor','Feridas que não Cicatrizam','Manchas que Coçam']).
doenca(['Bem','Débora']).

%recomendação em caso de doença
recomendacao('Acne','Higienizar a pele, remover diariamente a maquiagem, usar produtos oil-free ou não comedogênicos, e não espremer as lesões.').
recomendacao('Rosácea','Evitar bebidas muito quentes, alimentos condimentados, moderar a cafeína e as bebidas alcoólicas, e praticar fotoproteção.').
recomendacao('Impetigo','Lavagem frequente das mãos, não compartilhar objetos de uso pessoal, evitar tocar nas feridas, lavar as lesões com água e sabão.').
recomendacao('Melasma','Fotoproteção, uso de chapéus de abas largas, de óculos escuros e de guarda-sol.').
recomendacao('Psoríase','Fotoproteção, uso de chapéus de abas largas, de óculos escuros e de guarda-sol.').
recomendacao('Micose','Não compartilhar objetos de uso pessoal, secar o corpo com atenção, evitar o uso de roupas molhadas por muito tempo, não abafar o couro cabeludo quando há umidade, e não compartilhar materiais de manicure.').
recomendacao('Dermatite Atópica','Hidratar a pele todos os dias, usar roupas de algodão ou de tecidos macios,  tomar banhos e duchas com água morna, secar a pele suavemente e evitar substâncias irritantes.').
recomendacao('Câncer de Pele','Evite exposição prolongada ao sol, use sempre proteção adequada, como bonés ou chapéus de abas largas, óculos escuros, e filtro solar, usar o filtro solar mais de uma vez durante o dia.').

lista([]).

%Interação inicial com o usuário.
dialogo :- 
	writeln('Esse é um teste para verificar se você possui alguma Doença de Pele.'),
    writeln('Qual é o seu nome?'), read_line_to_string(user_input, Nome_do_Paciente), write('Pronto, '), write(Nome_do_Paciente), write('! '),
    writeln('Agora podemos começar...'), nl,
    lista(NovaLista), Contador_Sintoma is 1, menu(Nome_do_Paciente,Contador_Sintoma,NovaLista). 
%O contador será usado para buscar o sintoma ao qual está atribuído.

%Pergunta ao usuário se ele possui tal sintoma, caso ele digite 1-sim, irá armazenar em uma lista, caso ele digite 2-não,  irá passar para a próxima sintoma
menu(Nome_do_Paciente,Contador_Sintoma,NovaLista) :- 
    ( Contador_Sintoma == 22, write(Nome_do_Paciente), writeln(', esses são os seus Sintomas:'), writeln(NovaLista), nl, adicionar_elemento('Cabeça',NovaLista,Lista), comparacao(Nome_do_Paciente,Lista) ) ; 
    ( Contador_Sintoma \= 22, sintoma(Contador_Sintoma,Sintoma), write(Nome_do_Paciente), write(', você possui '), write(Sintoma), writeln('?'), writeln('1 - Sim'), writeln('2 - Não'), read(Opcao), nl, condicao(Nome_do_Paciente,Opcao,Contador_Sintoma,NovaLista)).

%Escolhe o rumo a ser tomado dependendo do que o paciente digitar
condicao(Nome_do_Paciente,Opcao,Contador_Sintoma,NovaLista) :- 
    (Opcao == 1 , lista(Nome_do_Paciente,NovaLista,Contador_Sintoma)) ; ( Opcao == 2, Novo_Contador is Contador_Sintoma + 1, menu(Nome_do_Paciente,Novo_Contador,NovaLista)) ; ((Opcao \= 1 , Opcao \= 2) , menu(Nome_do_Paciente,Contador_Sintoma,NovaLista)).

%Função para adicionar um elemento na cabeça da lista
adicionar_elemento(Sintoma , NovaLista, Lista) :-
                   Lista = [Sintoma | NovaLista].

%Adiciona um elemento na lista e volta para o menu com o contador + 1, para que possa usar o próximo sintoma
lista(Nome_do_Paciente,NovaLista,Contador_Sintoma) :- 
    sintoma(Contador_Sintoma,Sintoma) ,
    adicionar_elemento(Sintoma,NovaLista,Lista), 
    Novo_Contador is Contador_Sintoma + 1, menu(Nome_do_Paciente,Novo_Contador,Lista).

%Chama uma lista de doença e adiciona 'fim', como último elemento, na lista de doença e de sintomas do usuário
comparacao(Nome_do_Paciente,ListaSintomas) :- 
    doenca(ListaDoenca), append(ListaDoenca, [fim], NovaListaDoenca), append(ListaSintomas, [fim], NovaListaSintomas), compare_01(Nome_do_Paciente,NovaListaDoenca,NovaListaSintomas).

%Corta a cabeça da lista de doença (nome da doença) e a cabeça da lista de sintomas ('Cabeça'), para que possam ser usado só os sintomas
compare_01(Nome_do_Paciente,[Cabeca1|Corpo1] , [Cabeca2|Corpo2]) :- 
    Cabeca1 \= Cabeca2 , compare_02(Nome_do_Paciente,Cabeca1,Corpo1, Corpo2).

%Compara a lista de sintomas da doença com a lista de sintomas do usuário, caso sejam compátiveis, o usuário será diagnosticado com tal doença
compare_02(Nome_do_Paciente,Doenca,[Cabeca1|NovoCorpo1] , [Cabeca2|NovoCorpo2]) :-  
    ( Cabeca1 == 'fim' , Cabeca2 == 'fim', recomendacao(Doenca,Recomendacao), write(Nome_do_Paciente), write(', dados os seus sintomas, você foi diagnoticado com * '),  write(Doenca), writeln(' *.'), nl, write('Recomendação: '), write(Recomendacao)) 
     																      	; 
    ( (  Cabeca1 \= 'fim' , Cabeca2 \= 'fim', Cabeca1 == Cabeca2), compare_02(Nome_do_Paciente,Doenca,NovoCorpo1, NovoCorpo2))
																			;   
	( Doenca == 'Bem' , write(Nome_do_Paciente), writeln(', não foi possível identificar uma doença. Procure um médico para mais informações.') ).




