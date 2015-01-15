SET DEFINE OFF;
ALTER SESSION SET CURRENT_SCHEMA = UNIFIED_USE;

UPDATE REFDATAITEM
SET "VALUE" = '{
"login": {
    "label": {
        "username": "Username",
        "password": "Password",
        "profile": "Profile",
        "location": "Location",
        "login": "Login"
    },
    "error": {
        "INVALID_CREDENTIALS": "Invalid credentials.",
        "USER_NOT_FOUND": "Unknown user.",
        "MISSING_CREDENTIALS": "Username and password is mandatory.",
        "MISSING_USERNAME": "Username is mandatory.",
        "INVALID_SESSION_ID": "Invalid session identifier.",
        "SESSION_NOT_FOUND": "Session not found.",
        "errorLoadingIpAndHostname": "Error getting computer information.",
        "instanceAlreadyOpen": "Another instance of the VFE portal is open.",
        "notLoggedIn": "Not logged in. Redirecting to portal...",
        "invalidParameters": "Invalid parameters for a change profile operation.",
        "INVALID_PROFILE": "User does not have permissions to access with the selected profile.",
        "MISSING_PROFILE": "Select one profile to change to."
    },
    "message": {
        "authenticatingUser": "Authenticating user...",
        "updatingSession": "Updating session...",
        "openingPortal": "Loading portal...",
        "loggingOut": "Logging out..."
    }
}
}'
WHERE NAME = 'login.i18n.en';

UPDATE REFDATAITEM
SET "VALUE" = '{
"login": {
    "label": {
        "username": "Utilizador",
        "password": "Password",
        "profile": "Perfil",
        "location": "Local",
        "login": "Entrar"
    },
    "error": {
        "INVALID_CREDENTIALS": "Credenciais inválidas.",
        "USER_NOT_FOUND": "Utilizador desconhecido.",
        "MISSING_CREDENTIALS": "Utilizador e password são obrigatórios.",
        "MISSING_USERNAME": "Utilizador é obrigatório.",
        "INVALID_SESSION_ID": "Identificador de sessão inválido.",
        "SESSION_NOT_FOUND": "Sessão não encontrada.",
        "errorLoadingIpAndHostname": "Erro ao obter detalhes da máquina.",
        "instanceAlreadyOpen": "Já existe uma instância do portal Vodafone FrontEnd aberta.",
        "notLoggedIn": "Não foi encontrada uma sessão. A regressar ao portal...",
        "invalidParameters": "Parametros inválidos para a mudança de perfil!",
        "INVALID_PROFILE": "O utilizador não ter permissões para usar o perfil seleccionado.",
        "MISSING_PROFILE": "Escolha um perfil válido."
    },
    "message": {
        "authenticatingUser": "A autenticar...",
        "updatingSession": "A atualizar a sessão...",
        "openingPortal": "A carregar o portal...",
        "loggingOut": "A terminar a sessão..."        
    }
}
}'
WHERE NAME = 'login.i18n.pt';

COMMIT;