implement main
    open core, file, stdio

domains
    type = еженедельная; ежедневная; ежемесячная.

class facts - newspaper
    издание : (integer Id_Издания, string Название_Газеты, type Тип, integer Цена).
    подписчик : (integer Id_Подписчика, string ФИО, integer Возраст, string Адрес).
    подписался : (integer Id_Издания, integer Id_Подписчика, string Дата, integer Время, integer Выручка).

class facts
    s : (real Sum) single.

clauses
    s(0).

class predicates
    подписан_на : (string ФИО) nondeterm.
    стоимость_издания : (string Название_Газеты) nondeterm.
    подписчики_издания : (string Название_Газеты) nondeterm.
    сумма_продаж : (string Название_Газеты) nondeterm.
    тип_издания : (string Название_Газеты) nondeterm.

clauses
    подписан_на(X) :-
        подписчик(N, X, _, _),
        write("Подписчик: ", X, "\n"),
        подписался(NP, N, _, _, _),
        издание(NP, NameIs, _, _),
        write("Издание: ", NameIs, "\n"),
        nl,
        fail.
    подписан_на(X) :-
        подписчик(_, X, _, _),
        write("Конец списка\n"),
        nl.

    стоимость_издания(X) :-
        write("Название издания: ", X, "\n"),
        издание(_, X, _, C),
        write("Цена: ", C, "\n"),
        nl,
        fail.
    стоимость_издания(X) :-
        издание(_, X, _, _),
        nl.

    подписчики_издания(X) :-
        издание(NP, X, _, _),
        write("Издание: ", X, "\n"),
        подписчик(N, Name, _, _),
        подписался(NP, N, _, _, _),
        write("Подписчик: ", Name, "\n"),
        nl,
        fail.
    подписчики_издания(X) :-
        издание(_, X, _, _),
        write("Конец списка\n"),
        nl.

    сумма_продаж(X) :-
        издание(NP, X, _, _),
        %assert(s(0)),
        write("Издание: ", X, "\n"),
        подписался(NP, _, _, _, C),
        s(Sum),
        assert(s(Sum + C)),
        fail.
    сумма_продаж(X) :-
        издание(_, X, _, _),
        s(Sum),
        write("Cумма продаж:", Sum, "\n"),
        nl.
    сумма_продаж(X) :-
        издание(_, X, _, _),
        nl.

    тип_издания(X) :-
        write("Название издания: ", X, "\n"),
        издание(_, X, T, _),
        write("Тип выпуска: ", T, "\n"),
        nl,
        fail.
    тип_издания(X) :-
        издание(_, X, _, _),
        nl.

    run() :-
        console::init(),
        reconsult("..\\newspaper.txt", newspaper),
        подписан_на("Иванов Сергей Иванович"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\newspaper.txt", newspaper),
        стоимость_издания("Аргументы и факты"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\newspaper.txt", newspaper),
        подписчики_издания("Аргументы и факты"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\newspaper.txt", newspaper),
        сумма_продаж("Комсомольская правда"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\newspaper.txt", newspaper),
        тип_издания("Комсомольская правда"),
        fail.

    run() :-
        succeed.

end implement main

goal
    console::run(main::run).
