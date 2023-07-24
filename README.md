# Teste EOS App - Arquitetura de MicroFront-end com Clean Architecture

O projeto está organizado na seguinte estrutura:

- **base_app:** Responsável por rodar a aplicação. Único que conhece todos os Micro Apps da aplicação.
- **dependencies:** Mantém centralizadas todas as dependências dos Micro Apps.
- **Commons:** Mantém tudo que é compartilhado entre os Micro Apps (Widgets, mixins, entities, infra, etc).
- **core:** Toda configuração que é compartilhada com os Micro Apps (Interface de um Micro App, base de classe)
- Os demais packages que possuem o nome indicando uma feature são Micro Apps. Devem ser seguidas algumas regras desse tipo de package:
  1. Um Micro App **nunca** deve referenciar outro Micro App (Se a lógica for compartilhada, mover para o package core)
  2. Seguir em todos os Micro Apps a mesma arquitetura e estrutura de pastas
  3. Não adicionar dependências externas nesses packages (Sempre adicionar no package dependencies)

Abaixo seguem informações sobre a estrutura do projeto, setup e outras considerações.

## **1. Arquitetura do projeto**

O projeto é dividido em packages, onde o package implementa um Micro App, que segue a Clean Architecture.

![](./.images/clean.jpg)

Estrutura básica de pastas para os Micro Apps. Pode variar de acordo com a necessidade. Esta estrutura deve ser espelhada nos testes:

```yaml
/lib
/domain
/entities
/usecases
/data
/repositories
/presentation
/views
/cubit
/widgets
<main>.dart
```

### 1.1 Camadas

#### **Domain**

Essa camada é o core do Microapp. É onde são implementadas as entities e usecases, contendo, respetivamente, as regras
de negócio corporativas e regras de negócio da aplicação.

Nessa camada estarão definidas as ‘interfaces’ da camada data. Ocasionalmente existirão também algumas ‘interfaces’ da
camada infrastructure, como Navigation e DependencyManager.

Deve-se ter muito cuidado ao trabalhar nessa camada... Ela deve ter o mínimo de dependências externas possível. Quando
necessário adicionar algum package externo aqui, devem ser tomadas certas precauções, como:

- verificar o **real benefício** da sua utilização
- verificar o número de contribuintes desse package
- verificar se recebe atualizações constantemente
- verificar a sua popularidade/likes no pub.dev

#### **Data**

Na camada Data serão realizadas as chamadas a datasources locais ou externos e o tratamento dos dados de envio/recebimento por meio dos Repositories.

O tratamento dos dados, quando necessário, deve ser feito em classes "Model" específicas. Essas classes devem saber as
características dos dados sendo enviados ou recebidos (parse de JSON, parse de Model para Entity e vice-versa).

A comunicação com datasources externos/locais não será feita diretamente. Deve ser por ‘interface’ adapters. A
implementação dessa ‘interface’ (HttpClient, por exemplo) será recebida no repository através do seu constructor.

A definição dessas ‘interfaces’ adapters será localizada na própria camada data, por se tratar de uma dependência para a
sua execução. A sua implementação, no entando, deve ser feita em outra camada.

#### **Infrastructure**

Essa camada serve para isolar completamente o App de packages externos e suas particularidades. Internamente, o app trabalhará apenas com dados/classes locais, conhecidas por ele. Com a correta utilização dessa camada, se for necessário substituir um package por outro, o impacto tende a ser mínimo.

Como exemplo podemos pegar o caso comentado acima, onde os repositories da camada Data receberão as implementações de interface adapters. Esses adapters, como o nome já diz, adaptam uma classe externa para ser utilizada seguindo um padrão pré-definido no próprio App.

Podemos usar a comunicação local storage como exemplo:

- Interface local Storage:
  - Define como a comunicação deve ocorrer
  - Define os tipos de retorno e exceptions lançadas
- Adapter da local Storage - Implementação utilizando package Hive:
  - Define uma implementação da interface local Storage, utilizando internamente o Hive.

#### **Presentation**

Essa camada é responsável por tudo que tange a parte visual do App.

Nessa camada são definidos basicamente:

- Interfaces:
  - Contratos para a criação dos presenters e seus dados (state)
- Presenters:
  - Controlam o fluxo de dados da uma ou mais views
  - São implementados utilizando algum package externo, como Cubit/Bloc.
- Cubit/Components:
  - UI/componentes criados com Flutter

#### **Main**

Essa camada está representada na estrutura acima como o arquivo `<main>.dart`. Nesse arquivo é feita toda a composição dos módulos/Micro Apps.

Isso significa que a camada Main conhece todas as outras camadas e será a responsável por montar toda a estrutura necessária para executar o Micro App. É essa camada que, por exemplo, fará a instanciação dos usecases e os injetará nos presenters.

Nesse projeto, essa camada é montada com a utilização do package flutter_modular.

Normalmente esse arquivo receberá o nome do Micro App que ele representa, por exemplo, para o Micro App de taskManager existirá um arquivo `taskManager.dart` na pasta raiz do App.

### 1.2 Comunicação entre camadas

Como regra, um microApp nunca deve se comunicar diretamente com outro MicroApp para nao causar acoplamento, por esse motivo é essencial ultilizar o Event Bus.

### 1.3 Adicionando Micro Apps

Um Micro App pode ser adicionado através do comando:

```bash
flutter create -t package login
```

As únicas dependências que o Micro App pode ter são:

- local package: core
- local package: dependencies
- local package: commons

Exemplo:

```yaml
dependencies:
  core:
    path: ../core
  dependencies:
    path: ../dependencies

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^1.0.4
```

Cada Micro App deve seguir uma padronização:
Deve conter um arquivo `analysis_options.yaml` com as regras de análise/formatação do código. Mais detalhes na
seção "Padronização e boas práticas".

## **2. Setup**

É essencial entrar em cada pasta do projeto e dar um flutter pub get para conseguir rodar o projeto

## **3. Padronização e boas práticas**

Projeto configurado com o package [Flutter Lints](https://pub.dev/packages/flutter_lints).

As regras foram centralizadas no pacote `core`, no arquivo `linter_rules.yaml`.  
Cada package deve possuir um arquivo `analysis_options.yaml` com uma estrutura básica referenciando o package core (e podendo conter regras específicas):

```yaml
include: package:core/linter_rules.yaml
# Regras específicas do módulo abaixo do include...
```

### 3.1 Nome de classes e arquivos

#### **Domain**

Por padrão as entidades tem o sufixo "entity" (nem no arquivo e nem no nome da classe).
Por outro lado os usecases TEM o sufixo "usecase" no ARQUIVO e no nome da CLASSE.
Ex: o arquivo get_user_usecase contém a classe GetUserUsecase

#### **Data**

Todos os arquivos model têm o sufixo "model" no nome do arquivo e no nome da classe
Ex: o arquivo user_model contém a classe UserModel

### 4.2 Utilização dos temas

O projeto está dísponivel com o lightTheme e darkTheme
