# Ambiente de desenvolvimento Hybris com Docker
O ambiente de desenvolvimento Hybris com docker segue boas práticas de virtualização para atingir melhor performance e agilidade durante o desenvolvimento.
Encontra-se em fase de desenvolvimento e testes.

### Pré-requisitos
- Instalar o Docker Toolbox - https://www.docker.com/products/docker-toolbox
- Configurar o Git - https://git-scm.com/
- Instalar o Python - https://www.python.org/ftp/python/3.6.3/python-3.6.3-amd64.exe (o caminho de instalação recomendado é /c/python/)

### Passo 1 - Hybris Suite
Adicionar o hybris-commerce-suite-5.7.0.28.tar.gz na raiz.
**WireMock** - Adicionar o mocks.tar.gz.
### Passo 2 - Machine
Primeira etapa deverá criar nossa máquina via docker. Logo abaixo os paramêtros disponíveis:

* --create - Cria a máquina via docker. Driver padrão é o virtualbox. Ponto Importante, executar esse comando fora da rede privada para atualizar o core do linux.
* --start - Liga a máquina via docker.
* --stop - Desliga a máquina via docker.

```
./bin/machine.sh --FLAG hybris
```

### Passo 3 - Image
Segunda etapa deverá criar uma imagem e um container por vez. Escolha um todos seguintes micro-serviços disponíveis: wiremock, frontend e hybris.

* ${NOME-DO-IMAGEM} - frontend e hybris.<br />
${frontend} - Cria uma imagem linux com os assets disponíveis para o Front-end Hybris.<br />
${hybris} - Cria uma imagem linux com o commerce suite na versão 5.7.0.28 do Hybris.<br />
${wiremock} - Cria uma imagem linux com o wiremock na versão 2.7.1. Para atualizar o endpoint, usamos o link http://IP-MÁQUINA:<8888>/SERVIÇO <br />
* ${PROXY-HTTP} - ${no-http-proxy} para gerar uma imagem linux sem proxy.
* ${PROXY-HTTPS} - ${no-https-proxy} para gerar uma imagem linux sem proxy.
* [BRANCHES] - Adicionar o nome da branch ou do repositório GIT (o caminho do source é a pasta data). Exemplo: [BRANCHMINIFY_PP].

```
./bin/image.sh ${NOME-DO-IMAGEM} ${PROXY-HTTP} ${PROXY-HTTPS} [BRANCHES]
```

### Passo 4 - Container
Terceira etapa constituem os comandos mais usados na fase de desenvolvimento.
* --start - Liga o container.
* --stop - Desliga o container.
* --properties - Copia o local.properties e localextensions.xml para o container.
* --new - Atualiza a branch, caso necessário. Depois executa o comando --clear.
* --init - Cria a pasta de configuração do Hybris. (Usar apenas quando necessário)
* --init-system - A inicialização deixa as definições existentes do Hybris a partir do zero.
* --clear - Cria a partir do zero todas as classes do Hybris.
* --server-debug - Inicia o servidor Hybris no modo DEBUG.
* --server - Inicia o servidor hybris.
* --run - Roda linhas de comandos no container. [COMANDOS]

```
./bin/container.sh ${--FLAG} ${NOME-DO-CONTAINER} [COMANDOS]
```

### Passo 5 - Environment(Proxy)
**Em construção** - Controle automático de configuração da rede privada e rede pública.
```
./bin/environment.sh
```