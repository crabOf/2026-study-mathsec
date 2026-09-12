# Лабораторная работа 1. Шифры простой замены
# Цезарь и Атбаш на русском алфавите

function caesar_cipher(text::String, k::Int)
    # алфавит сразу делаю массивом символов, так удобнее для индексов
    alf = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    m = length(alf)
    res = ""

    for c in text
        low_c = lowercase(c)
        idx = findfirst(==(low_c), alf)

        if idx !== nothing
            # формула сдвига по модулю m
            # в Julia индексы с 1, поэтому тут idx - 1 и потом + 1
            new_idx = mod(idx - 1 + k, m) + 1
            new_c = alf[new_idx]

            if isuppercase(c)
                res *= string(uppercase(new_c))
            else
                res *= string(new_c)
            end
        else
            # пробелы и знаки не трогаю
            res *= string(c)
        end
    end

    return res
end

function atbash_cipher(text::String)
    alf = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    rev_alf = reverse(alf)
    res = ""

    for c in text
        low_c = lowercase(c)
        idx = findfirst(==(low_c), alf)

        if idx !== nothing
            # берем символ с той же позиции, но из перевернутого алфавита
            new_c = rev_alf[idx]

            if isuppercase(c)
                res *= string(uppercase(new_c))
            else
                res *= string(new_c)
            end
        else
            res *= string(c)
        end
    end

    return res
end

# проверка работы
msg = "Добрый вечер! Скоро пара"

println("Исходный текст: ", msg)

# k произвольное, поэтому беру случайное число от 1 до 32
k = rand(1:32)
println("Случайный ключ k = ", k)

println("Шифр Цезаря: ", caesar_cipher(msg, k))
println("Шифр Атбаш:  ", atbash_cipher(msg))
