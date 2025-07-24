USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_21`;


DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_21`()
BEGIN
	DECLARE vAluguel VARCHAR(10) DEFAULT '10001';
    DECLARE vCliente VARCHAR(10) DEFAULT '1002';
    DECLARE vHospedagem VARCHAR(10) DEFAULT '8635';
    DECLARE vDataInicio DATE DEFAULT '2023-03-01';
    DECLARE vDataFinal DATE DEFAULT '2023-03-05';
    DECLARE vPrecoTotal DECIMAL(10,2) DEFAULT 550.23;
    SELECT vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal;
END$$
DELIMITER ;



USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_22`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_22`()
BEGIN
	DECLARE vAluguel VARCHAR(10) DEFAULT '10001';
    DECLARE vCliente VARCHAR(10) DEFAULT '1002';
    DECLARE vHospedagem VARCHAR(10) DEFAULT '8635';
    DECLARE vDataInicio DATE DEFAULT '2023-03-01';
    DECLARE vDataFinal DATE DEFAULT '2023-03-05';
    DECLARE vPrecoTotal DECIMAL(10,2) DEFAULT 550.23;
   INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);
END$$
DELIMITER ;

SELECT * FROM alugueis WHERE reserva_id = '10001';
CALL novoAluguel_22;

USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_23`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_23`
(vAluguel VARCHAR(10), vCliente VARCHAR(10), vHospedagem VARCHAR(10), vDataInicio DATE, vDataFinal DATE, vPrecoTotal DECIMAL(10,2))
BEGIN
   INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);
END$$
DELIMITER ;

CALL novoAluguel_23('10002','1003','8635','2023-03-06','2023-03-10',600);
SELECT * FROM alugueis WHERE reserva_id = '10002';
CALL novoAluguel_23('10003','1004','8635','2023-03-10','2023-03-12',250);
SELECT * FROM alugueis WHERE reserva_id IN ('10002', '10003');



-- NOVA PROCEDURE --
USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_24`;
DELIMITER $$
USE `insight_places`$$
-- Criação de uma stored procedure chamada 'novoAluguel_23'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_24`(
    vAluguel VARCHAR(10),       -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vCliente VARCHAR(10),       -- Parâmetro de entrada: ID do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),    -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,           -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDataFinal DATE,            -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vDias INTEGER DEFAULT 0;          -- Variável para armazenar o número de dias do aluguel
    DECLARE vPrecoTotal DECIMAL(10,2);        -- Variável para armazenar o preço total do aluguel

    -- Calcula a diferença em dias entre a data final e a data de início
    -- A função DATEDIFF retorna o número de dias entre duas datas
    SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));

    -- Calcula o preço total multiplicando o número de dias pelo preço unitário
    SET vPrecoTotal = vDias * vPrecoUnitario;

    -- Insere os dados na tabela 'alugueis'
    -- Os valores inseridos são os parâmetros passados para a procedure e o preço total calculado
    INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);
END$$

CALL novoAluguel_24('10004','1004','8635','2023-03-13','2023-03-16',40);
SELECT * FROM alugueis WHERE reserva_id = '10004';


-- NOVA PROCEDURE --
USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_25`;
DELIMITER $$
USE `insight_places`$$
-- Criação de uma stored procedure chamada 'novoAluguel_23'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_25`(
    vAluguel VARCHAR(10),       -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vCliente VARCHAR(10),       -- Parâmetro de entrada: ID do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),    -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,           -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDataFinal DATE,            -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vDias INTEGER DEFAULT 0;          -- Variável para armazenar o número de dias do aluguel
    DECLARE vPrecoTotal DECIMAL(10,2);        -- Variável para armazenar o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);           -- Variavel para armazemar a mensagem de erro capturada
    DECLARE EXIT HANDLER FOR 1452             -- Captura erros de chave estrangeira (Código 1452) e define uma mensagem de erro específica
    BEGIN
		SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';   -- Mensagem a ser exibida qunato ao erro detectado
        SELECT vMensagem;         -- Mostra a mensagem após o erro detectado                                                               
    END;

    -- Calcula a diferença em dias entre a data final e a data de início
    -- A função DATEDIFF retorna o número de dias entre duas datas
    SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));

    -- Calcula o preço total multiplicando o número de dias pelo preço unitário
    SET vPrecoTotal = vDias * vPrecoUnitario;

    -- Insere os dados na tabela 'alugueis'
    -- Os valores inseridos são os parâmetros passados para a procedure e o preço total calculado
    INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);
    SET vMensagem = 'Aluguel Incluído com sucesso.';
	SELECT vMensagem;
END$$

CALL novoAluguel_25('10005','10001','8635','2023-03-17','2023-03-25',40);
CALL novoAluguel_25('10005','1004','8635','2023-03-17','2023-03-25',40);
SELECT * FROM alugueis WHERE reserva_id = '1004';


-- NOVA PROCEDURE --
USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_31`;
DELIMITER $$
USE `insight_places`$$
-- Criação de uma stored procedure chamada 'novoAluguel_23'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_31`
(vAluguel VARCHAR(10), vClienteNome VARCHAR(150), vHospedagem VARCHAR(10), vDataInicio DATE,
vDataFinal DATE, vPrecoUnitario DECIMAL(10,2))
BEGIN
    DECLARE vCliente VARCHAR(10);
    DECLARE vDias INTEGER DEFAULT 0;
    DECLARE VPrecoTotal DECIMAL(10,2);
    DECLARE vMensagem VARCHAR(100);
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;
    END;
    SET vDias = (SELECT DATEDIFF (vDataFinal, vDataInicio));
    SET vPrecoTotal = vDias * vPrecoUnitario;
    SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;
    INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, 
    vDataFinal, vPrecoTotal);
    SET vMensagem = 'Aluguel incluido na base com sucesso.';
    SELECT vMensagem;
END$$

CALL novoAluguel_31('10007','Luana Moura','8635','2023-03-20','2023-03-30',40);
SELECT * FROM alugueis WHERE reserva_id = '10001';
CALL novoAluguel_31;


-- NOVA PROCEDURE
USE `insight_places`;
DROP procedure IF EXISTS `insight_places`.`novoAluguel_32`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_32`(vAluguel VARCHAR(10), vClienteNome VARCHAR(150), vHospedagem VARCHAR(10), vDataInicio DATE,
vDataFinal DATE, vPrecoUnitario DECIMAL(10,2))
BEGIN
    DECLARE vCliente VARCHAR(10);
    DECLARE vDias INTEGER DEFAULT 0;
    DECLARE vNumCliente INTEGER;
    DECLARE VPrecoTotal DECIMAL(10,2);
    DECLARE vMensagem VARCHAR(100);
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;
    END;
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
    IF vNumCliente > 1 THEN
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel pelo nome.';
        SELECT vMensagem;
    ELSE
        SET vDias = (SELECT DATEDIFF (vDataFinal, vDataInicio));
        SET vPrecoTotal = vDias * vPrecoUnitario;
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, 
        vDataFinal, vPrecoTotal);
        SET vMensagem = 'Aluguel incluido na base com sucesso.';
        SELECT vMensagem;
    END IF;
END$$

CALL novoAluguel_32('10007','Júlia Pires','8635','2023-03-26','2023-04-30',40);
SELECT * FROM clientes WHERE nome = 'Júlia Pires';


CALL novoAluguel_32('10008','Eleilton Santos','8635','2023-03-25','2023-04-30',40);
SELECT * FROM clientes WHERE nome = 'Eleilton Santos';


-- NOVA PROCEDURE
-- Define o banco de dados que será utilizado
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_33`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_33' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_33`(
    vAluguel VARCHAR(10),        -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vClienteNome VARCHAR(150),   -- Parâmetro de entrada: Nome do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),     -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,            -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDataFinal DATE,             -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);         -- Variável para armazenar o ID do cliente
    DECLARE vDias INTEGER DEFAULT 0;      -- Variável para armazenar o número de dias do aluguel
    DECLARE vNumCliente INTEGER;          -- Variável para contar quantos clientes têm o nome especificado
    DECLARE vPrecoTotal DECIMAL(10,2);    -- Variável para armazenar o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);       -- Variável para armazenar mensagens de erro ou sucesso

    -- Declaração de um handler para tratar erros de chave estrangeira (código de erro 1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
    END;

    -- Conta quantos clientes na tabela 'clientes' têm o nome especificado (vClienteNome)
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);

    -- Verifica se há mais de um cliente com o mesmo nome
    IF vNumCliente > 1 THEN
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel pelo nome.';
        SELECT vMensagem;  -- Retorna a mensagem de erro

    -- Verifica se não há nenhum cliente com o nome especificado
    ELSEIF vNumCliente = 0 THEN
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro

    -- Caso haja exatamente um cliente com o nome especificado
    ELSE
        -- Calcula a diferença em dias entre a data final e a data de início
        SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));

        -- Calcula o preço total multiplicando o número de dias pelo preço unitário
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome especificado
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere os dados na tabela 'alugueis'
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Define a mensagem de sucesso
        SET vMensagem = 'Aluguel incluído na base com sucesso.';
        SELECT vMensagem;  -- Retorna a mensagem de sucesso
    END IF;
END$$

-- Restaura o delimitador padrão (;)
DELIMITER ;

CALL novoAluguel_33('10008','Eleilton Santos','8635','2023-03-25','2023-04-30',40);
SELECT * FROM clientes WHERE nome = 'Eleilton Santos';
DELETE FROM alugueis WHERE reserva_id = '10008';



-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_34`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_33' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_34`(
    vAluguel VARCHAR(10),        -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vClienteNome VARCHAR(150),   -- Parâmetro de entrada: Nome do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),     -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,            -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDataFinal DATE,             -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);         -- Variável para armazenar o ID do cliente
    DECLARE vDias INTEGER DEFAULT 0;      -- Variável para armazenar o número de dias do aluguel
    DECLARE vNumCliente INTEGER;          -- Variável para contar quantos clientes têm o nome especificado
    DECLARE vPrecoTotal DECIMAL(10,2);    -- Variável para armazenar o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);       -- Variável para armazenar mensagens de erro ou sucesso

    -- Declaração de um handler para tratar erros de chave estrangeira (código de erro 1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
    END;

    -- Conta quantos clientes na tabela 'clientes' têm o nome especificado (vClienteNome)
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
    CASE vNumCliente
    WHEN 0 THEN
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
	WHEN 1 THEN
		  -- Calcula a diferença em dias entre a data final e a data de início
        SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));

        -- Calcula o preço total multiplicando o número de dias pelo preço unitário
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome especificado
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere os dados na tabela 'alugueis'
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Define a mensagem de sucesso
        SET vMensagem = 'Aluguel incluído na base com sucesso.';
        SELECT vMensagem;  -- Retorna a mensagem de sucesso
    ELSE  
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
   END CASE  ;   
        
END$$

CALL novoAluguel_34('10008','Eleilton Santos','8635','2023-03-25','2023-04-30',40);
CALL novoAluguel_34('10008','Maitê Marcolan','8635','2023-03-20','2023-04-25',40);
CALL novoAluguel_34('10008','Luana Moura', '8635', '2023-03-30', '2023-04-23',40);


-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_35`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_33' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_35`(
    vAluguel VARCHAR(10),        -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vClienteNome VARCHAR(150),   -- Parâmetro de entrada: Nome do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),     -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,            -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDias INTEGER,             -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);         -- Variável para armazenar o ID do cliente
    DECLARE vDataFinal INTEGER DEFAULT 0;      -- Variável para armazenar o número de dias do aluguel
    DECLARE vNumCliente INTEGER;          -- Variável para contar quantos clientes têm o nome especificado
    DECLARE vPrecoTotal DECIMAL(10,2);    -- Variável para armazenar o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);       -- Variável para armazenar mensagens de erro ou sucesso

    -- Declaração de um handler para tratar erros de chave estrangeira (código de erro 1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
    END;

    -- Conta quantos clientes na tabela 'clientes' têm o nome especificado (vClienteNome)
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
    CASE vNumCliente
    WHEN vNumCliente = 0 THEN
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
	WHEN vNumCliente = 1 THEN
		  -- Calcula a diferença em dias entre a data final e a data de início
		-- SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
        SET vDataFinal = (SELECT vDataInicio + INTERVAL vDias DAY);

        -- Calcula o preço total multiplicando o número de dias pelo preço unitário
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome especificado
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere os dados na tabela 'alugueis'
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Define a mensagem de sucesso
        SET vMensagem = 'Aluguel incluído na base com sucesso.';
        SELECT vMensagem;  -- Retorna a mensagem de sucesso
   WHEN vNumCliente > 1 THEN
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
   END CASE  ;   
        
END$$

DELETE FROM alugueis WHERE reserva_id = '10008';
CALL novoAluguel_34('10008','Ilton Santos','8635','2023-03-25','2023-04-30',40);
CALL novoAluguel_34('10008','Yasmim Saraiva','8635','2023-03-20','2023-04-25',40);
CALL novoAluguel_34('10008','Luana Moura', '8635', '2023-03-30', '2023-04-23',40);



-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_36`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_33' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_36`(
    vAluguel VARCHAR(10),        -- Parâmetro de entrada: ID do aluguel (tipo VARCHAR)
    vClienteNome VARCHAR(150),   -- Parâmetro de entrada: Nome do cliente (tipo VARCHAR)
    vHospedagem VARCHAR(10),     -- Parâmetro de entrada: ID da hospedagem (tipo VARCHAR)
    vDataInicio DATE,            -- Parâmetro de entrada: Data de início do aluguel (tipo DATE)
    vDias INTEGER,             -- Parâmetro de entrada: Data final do aluguel (tipo DATE)
    vPrecoUnitario DECIMAL(10,2) -- Parâmetro de entrada: Preço unitário por dia (tipo DECIMAL)
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);         -- Variável para armazenar o ID do cliente
    DECLARE vDataFinal INTEGER DEFAULT 0;      -- Variável para armazenar o número de dias do aluguel
    DECLARE vNumCliente INTEGER;          -- Variável para contar quantos clientes têm o nome especificado
    DECLARE vPrecoTotal DECIMAL(10,2);    -- Variável para armazenar o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);       -- Variável para armazenar mensagens de erro ou sucesso

    -- Declaração de um handler para tratar erros de chave estrangeira (código de erro 1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
    END;

    -- Conta quantos clientes na tabela 'clientes' têm o nome especificado (vClienteNome)
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
    CASE vNumCliente
    WHEN vNumCliente = 0 THEN
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
	WHEN vNumCliente = 1 THEN
		  -- Calcula a diferença em dias entre a data final e a data de início
        -- SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
        SET vDataFinal = (SELECT vDataInicio + INTERVAL vDias DAY);

        -- Calcula o preço total multiplicando o número de dias pelo preço unitário
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome especificado
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere os dados na tabela 'alugueis'
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Define a mensagem de sucesso
        SET vMensagem = 'Aluguel incluído na base com sucesso.';
        SELECT vMensagem;  -- Retorna a mensagem de sucesso
   WHEN vNumCliente > 1 THEN
		SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;  -- Retorna a mensagem de erro
   END CASE  ;   
        
END$$


CALL novoAluguel_36('10009','Rafael Peixoto','8635','2023-04-05', 5, 40);
SELECT * FROM alugueis WHERE reserva_id = '10009';


CREATE DEFINER=`root`@`localhost` PROCEDURE `calculaDataFinal_38`(vDataInicio DATE, INOUT vDataFinal DATE, vDias INTEGER)
BEGIN
DECLARE vContador INTEGER;
DECLARE vDiaSemana INTEGER;
SET vContador = 1;
SET vDataFinal = vDataInicio;
WHILE vContador < vDias
DO
		SET vDias = (SELECT dayofweek(STR_TO_DATE(vDataFinal, '%Y-%m-5d')));
        IF (vDiasSemana <> 7 AND vDiasSemana <> 1) THEN
			SET vContador = vContador + 1;
        END IF;
        SET vDataFinal = (SELECT vDataFinal + INTERVAL 1 DAY);
END WHILE;        
END;


-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_38`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_37' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_38`
(
    vAluguel VARCHAR(10),       -- ID do aluguel
    vClienteNome VARCHAR(150),  -- Nome do cliente
    vHospedagem VARCHAR(10),    -- ID da hospedagem
    vDataInicio DATE,           -- Data de início do aluguel
    vDias INTEGER,              -- Número de dias do aluguel
    vPrecoUnitario DECIMAL(10,2) -- Preço unitário por dia
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);      -- Armazenará o ID do cliente
    -- DECLARE vContador INTEGER;         -- Contador para o loop
    -- DECLARE vDiaSemana INTEGER;        -- Armazenará o dia da semana (1=domingo, 7=sábado)
    DECLARE vDataFinal DATE;           -- Armazenará a data final do aluguel
    DECLARE vNumCliente INTEGER;       -- Armazenará o número de clientes com o nome fornecido
    DECLARE VPrecoTotal DECIMAL(10,2); -- Armazenará o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);   -- Armazenará mensagens de retorno

    -- Handler para tratar erros de chave estrangeira (1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;
    END;

    -- Verifica quantos clientes existem com o nome fornecido
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);

    -- Inicia um CASE para tratar diferentes cenários baseados no número de clientes encontrados
    CASE 
    WHEN vNumCliente = 0 THEN
        -- Se não houver clientes com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;

    WHEN vNumCliente = 1 THEN
        -- Se houver exatamente um cliente com o nome fornecido, procede com o cálculo da data final e do preço total

        -- Inicializa o contador e a data final
        -- SET vContador = 1;
        -- SET vDataFinal = vDataInicio;

        -- Loop para calcular a data final, ignorando sábados e domingos
        -- WHILE vContador < vDias DO
            -- Obtém o dia da semana da data final atual
            -- SET vDiaSemana = (SELECT DAYOFWEEK(STR_TO_DATE(vDataFinal,'%Y-%m-%d')));

            -- Se não for sábado (7) ou domingo (1), incrementa o contador
            -- IF (vDiaSemana <> 7 AND vDiaSemana <> 1) THEN
                -- SET vContador = vContador + 1;
            -- END IF;

            -- Incrementa a data final em um dia
            -- SET vDataFinal = (SELECT vDataFinal + INTERVAL 1 DAY);
        -- END WHILE;
        
        CALL calculaDataFinal_43(vDataInicio, vDataFinal, vDias);

        -- Calcula o preço total do aluguel
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome fornecido
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere o novo aluguel na tabela `alugueis`
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Retorna uma mensagem de sucesso
        SET vMensagem = 'Aluguel incluido na base com sucesso.';
        SELECT vMensagem;

    WHEN vNumCliente > 1 THEN
        -- Se houver mais de um cliente com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;
    END CASE;
END$$


DELETE FROM alugueis WHERE reserva_id = '10011';
CALL novoAluguel_37('10011','Livia Fogaça','8635','2023-04-20', 10, 40);
SELECT * FROM alugueis WHERE reserva_id = '10011';


CREATE DEFINER=`root`@`localhost` PROCEDURE `inclusao_cliente_39`(
    vAluguel VARCHAR(10), 
    vCliente VARCHAR(10), 
    vHospedagem VARCHAR(10), 
    vDataInicio DATE, 
    vDataFinal DATE, 
    vDias INTEGER, 
    vPrecoUnitario DECIMAL(10,2))
BEGIN
    DECLARE VPrecoTotal DECIMAL(10,2);
    SET VPrecoTotal = vDias * vPrecoUnitario;
    INSERT INTO alugueis 
    VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, VPrecoTotal);
END;


-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_39`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_37' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_39_nova`(
    vAluguel VARCHAR(10),       -- ID do aluguel
    vClienteNome VARCHAR(150),  -- Nome do cliente
    vHospedagem VARCHAR(10),    -- ID da hospedagem
    vDataInicio DATE,           -- Data de início do aluguel
    vDias INTEGER,              -- Número de dias do aluguel
    vPrecoUnitario DECIMAL(10,2) -- Preço unitário por dia
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vCliente VARCHAR(10);      -- Armazenará o ID do cliente
    DECLARE vDataFinal DATE;           -- Armazenará a data final do aluguel
    DECLARE vNumCliente INTEGER;       -- Armazenará o número de clientes com o nome fornecido
    DECLARE vMensagem VARCHAR(100);    -- Armazenará mensagens de retorno

    -- Handler para tratar erros de chave estrangeira (1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem; -- Retorna a mensagem de erro
    END;

    -- Verifica quantos clientes existem com o nome fornecido
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);

    -- Inicia um CASE para tratar diferentes cenários baseados no número de clientes encontrados
    CASE 
    WHEN vNumCliente = 0 THEN
        -- Se não houver clientes com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;

    WHEN vNumCliente = 1 THEN
        -- Se houver exatamente um cliente com o nome fornecido, procede com o cálculo da data final e inclusão do aluguel

        -- Chama a procedure 'calculaDataFinal_43' para calcular a data final do aluguel
        CALL calculaDataFinal_38(vDataInicio, vDataFinal, vDias);

        -- Obtém o ID do cliente com base no nome fornecido
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Chama a procedure 'inclusao_cliente_43' para inserir o novo aluguel na base de dados
        CALL inclusao_cliente_43(vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vDias, vPrecoUnitario);

        -- Retorna uma mensagem de sucesso
        SET vMensagem = 'Aluguel incluido na base com sucesso.';
        SELECT vMensagem;

    WHEN vNumCliente > 1 THEN
        -- Se houver mais de um cliente com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;
    END CASE;
END;




-- NOVA PROCEDURE
USE `insight_places`;

-- Remove a procedure 'novoAluguel_33' se ela já existir
DROP procedure IF EXISTS `insight_places`.`novoAluguel_40`;

-- Define o delimitador temporariamente como $$ para permitir a criação da procedure
DELIMITER $$

-- Criação da procedure 'novoAluguel_37' no banco de dados 'insight_places'
-- O DEFINER indica que o procedimento é criado pelo usuário 'root' no host 'localhost'
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_40`
(
    vClienteNome VARCHAR(150),  -- Nome do cliente
    vHospedagem VARCHAR(10),    -- ID da hospedagem
    vDataInicio DATE,           -- Data de início do aluguel
    vDias INTEGER,              -- Número de dias do aluguel
    vPrecoUnitario DECIMAL(10,2) -- Preço unitário por dia
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE vAluguel VARCHAR(10);
    DECLARE vCliente VARCHAR(10);      -- Armazenará o ID do cliente
    DECLARE vDataFinal DATE;           -- Armazenará a data final do aluguel
    DECLARE vNumCliente INTEGER;       -- Armazenará o número de clientes com o nome fornecido
    DECLARE VPrecoTotal DECIMAL(10,2); -- Armazenará o preço total do aluguel
    DECLARE vMensagem VARCHAR(100);   -- Armazenará mensagens de retorno

    -- Handler para tratar erros de chave estrangeira (1452)
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
        SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base.';
        SELECT vMensagem;
    END;

    -- Verifica quantos clientes existem com o nome fornecido
    SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);

    -- Inicia um CASE para tratar diferentes cenários baseados no número de clientes encontrados
    CASE 
    WHEN vNumCliente = 0 THEN
        -- Se não houver clientes com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;

    WHEN vNumCliente = 1 THEN
    
		-- Gera um novo ID para o aluguel, incrementando o maior ID existente na tabela 'alugueis' em 1.
         -- O resultado é armazenado na variável 'vAluguel'.
		SELECT CAST(MAX(CAST(reserva_id AS UNSIGNED)) + 1 AS CHAR) INTO vAluguel FROM alugueis;

			-- Chama a stored procedure 'calculaDataFinal_43' para calcular a data final do aluguel.
			-- A procedure recebe como parâmetros:
			--   - 'vDataInicio': Data de início do aluguel.
			--   - 'vDataFinal': Variável que armazenará a data final calculada.
			--   - 'vDias': Número de dias do aluguel.
        CALL calculaDataFinal_38(vDataInicio, vDataFinal, vDias);

        -- Calcula o preço total do aluguel
        SET vPrecoTotal = vDias * vPrecoUnitario;

        -- Obtém o ID do cliente com base no nome fornecido
        SELECT cliente_id INTO vCliente FROM clientes WHERE nome = vClienteNome;

        -- Insere o novo aluguel na tabela `alugueis`
        INSERT INTO alugueis VALUES (vAluguel, vCliente, vHospedagem, vDataInicio, vDataFinal, vPrecoTotal);

        -- Retorna uma mensagem de sucesso
        SET vMensagem = CONCAT('Aluguel incluido na base com sucesso. ID ' + vAluguel);
        SELECT vMensagem;

    WHEN vNumCliente > 1 THEN
        -- Se houver mais de um cliente com o nome fornecido, retorna uma mensagem de erro
        SET vMensagem = 'Este cliente não pode ser usado para incluir o aluguel porque não existe.';
        SELECT vMensagem;
    END CASE;
END$$


CALL novoAluguel_40('Livia Fogaça', '8635', '2023-05-15', 5, 45);

ALTER TABLE alugueis RENAME COLUMN alugueis_id TO aluguel_id;


CREATE DEFINER=`root`@`localhost` PROCEDURE `inclui_usuarios_lista`(lista VARCHAR(255))
BEGIN
	DECLARE nome VARCHAR(255);
    DECLARE restante VARCHAR(255);
    DECLARE pos INTEGER;
    SET restante = lista;
    WHILE INSTR(restante, ',') > 0 DO
		SET pos = INSTR(restante, ',');
        SET nome = LEFT(restante, pos - 1);
        INSERT INTO temp_nomes VALUES (nome);
        SET restante = SUBSTRING(restante, pos + 1);
    END WHILE;
    IF TRIM(restante) <> '' THEN
    INSERT INTO temp_nomes VALUES (TRIM(restante));
    END IF;
END;


-- temp_nomes (nome)

DROP TEMPORARY TABLE IF EXISTS temp_nomes;
CREATE TEMPORARY TABLE temp_nomes (nome VARCHAR(255));
CALL inclui_usuarios_lista('Luana Moura, Enrico Correia,Paulo Vieira,Marina Nunes');
SELECT * FROM temp_nomes;


CREATE DEFINER=`root`@`localhost` PROCEDURE `looping_cursor_54`()
BEGIN
	DECLARE fimCursor INTEGER DEFAULT 0;
    DECLARE vnome VARCHAR(255);
    DECLARE vemail VARCHAR(255);
    DECLARE cursor1 CURSOR FOR SELECT nome, email FROM temp_nomes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fimCursor = 1;
    OPEN cursor1;
    FETCH cursor1 INTO vnome, vemail;

    WHILE fimCursor = 0 DO
        SELECT vnome, vemail;
        FETCH cursor1 INTO vnome, vemail;
    END WHILE;

    CLOSE cursor1;
END;


DROP TEMPORARY TABLE IF EXISTS temp_nomes;
CREATE TEMPORARY TABLE temp_nomes (nome VARCHAR(255));
CALL inclui_usuarios_lista('João,Pedro,Maria,Luca, Joana,Beatriz');
SELECT * FROM temp_nomes;
CALL looping_cursor_54();


---

USE `insight_places`;
DROP procedure IF EXISTS `novosAlugueis_55`;

DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novosAlugueis_55`(lista VARCHAR(255),
vHospedagem VARCHAR(10), vDataInicio DATE,
vDias INTEGER, vPrecoUnitario DECIMAL(10,2))
BEGIN
    DECLARE vClienteNome VARCHAR(150);
    DECLARE fimCursor INTEGER DEFAULT 0;
    DECLARE vnome VARCHAR(255);
    DECLARE cursor1 CURSOR FOR SELECT nome FROM temp_nomes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fimCursor = 1;
    DROP TEMPORARY TABLE IF EXISTS temp_nomes;
    CREATE TEMPORARY TABLE temp_nomes (nome VARCHAR(255));
    CALL inclui_usuarios_lista(lista);
    OPEN cursor1;
    FETCH cursor1 INTO vnome;
    WHILE fimCursor = 0 DO
        SET vClienteNome = vnome;
        CALL novosAlugueis_55(vClienteNome, vHospedagem, vDataInicio, vDias, vPrecoUnitario);
        FETCH cursor1 INTO vnome;
    END WHILE;
    CLOSE cursor1;
    DROP TEMPORARY TABLE IF EXISTS temp_nomes;
END;

CALL novosAlugueis_55('Gabriel Carvalho,Erick Oliveira,Catarina Correia,Lorena Jesus', '8635', '2023-06-03', 7, 45);
SELECT * FROM alugueis WHERE aluguel_id IN ('10017', '10016', '10015', '10014');
