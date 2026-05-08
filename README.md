# Tripee Interview — Flutter Challenge

Projeto desenvolvido para o teste técnico da Tripee. O objetivo é uma aplicação Flutter que exibe uma lista paginada de agendamentos (schedules) com detalhes de rota, mapa interativo e filtros avançados.

### 🚀 Como rodar o projeto

1. **Instalar dependências:**

   ````flutter pub get`

2. **Configurar Variáveis de Ambiente:**

    O projeto utiliza flutter_dotenv. Crie um arquivo .env na raiz do projeto (não comitado) com o seguinte conteúdo:

   ````API_BASE_URL=https://tripee-interview.azurewebsites.net/v1`

3. **Executar o App:**

   ````flutter run`

4. **Executar Testes:**

   ````flutter test`

---

### 🛠️ Arquitetura e Decisões Técnicas

* **Clean Architecture:** Organização em camadas (data, domain, presentation) para garantir testabilidade e manutenção.

* **Gerenciamento de Estado:** Riverpod (StateNotifier) para controle reativo e modular.

* **Comunicação HTTP:** Dio com uma camada de ApiClient centralizada.

* **Mapas:** Utilizado flutter_map (OpenStreetMap) com polylines e markers que escalam dinamicamente conforme o zoom.

* **Imagens:** cached_network_image para performance e persistência, com tratamento de fallbacks para URLs de exemplo (example.com).

---

### ✨ Features Implementadas

* **Lista de Histórico (Schedules):**
    * Paginação invertida (carrega da última página para a primeira).
    * Scroll infinito com limite de 15 itens por página.
    * Agrupamento visual por data.

* **Busca e Filtros:**
    * Campo de busca com Debounce (evita requisições excessivas enquanto o usuário digita).
    * Filtro por intervalo de datas usando syncfusion_flutter_datepicker com seleção visual.

* **Tela de Detalhe:**
    * Mapa interativo com cálculo automático de bounds (ajuste de rota na tela).
    * Exibição de rota estimada e realizada.
    * Componente de RoutePoints customizado com linha pontilhada e pins estilizados.

* **UI/UX Enhancements:**
    * Status traduzidos e mapeados para cores semânticas.
    * Tema customizado com foco em alto contraste (Scaffold cinza leve, Cards brancos).
    * Widget DriverAvatar com sobreposição da logo do provedor.

---

### 📦 Models e Geração de Código

Os modelos (DTOs) do projeto foram implementados com freezed e json_serializable, aproveitando as vantagens de imutabilidade, tipos seguros e geração automática de fromJson/toJson.

* **Geração local com Freezed + JsonSerializable (padrão do projeto)** 
    As classes de modelo estão localizadas em lib/data/models/ e são anotadas com @freezed e @JsonSerializable.

    Para regerar os arquivos .g.dart e .freezed.dart, execute:
    ````dart run build_runner build`
    
    Certifique-se de ter as seguintes dependências no pubspec.yaml:

    dependencies:
        freezed_annotation: ^2.x.x
        json_annotation: ^4.x.x

    dev_dependencies:
        build_runner: ^2.x.x
        freezed: ^2.x.x
        json_serializable: ^6.x.x

* **Alternativa: Usar OpenAPI Generator (para regenerar a partir do Swagger)** 
    Esta abordagem é útil para manter os modelos totalmente sincronizados com o contrato da API, mas foi mantida como alternativa para evitar conflitos de versão e facilitar customizações locais.
    
---

### 📝 Notas sobre a API

* **URL Base utilizada:** https://tripee-interview.azurewebsites.net/v1

* **Observação sobre o Mock:** Notou-se que alguns IDs de agendamento retornam o mesmo payload estático. O app foi construído para ser resiliente a dados faltantes, utilizando placeholders de imagem e fallbacks de texto ("Motorista não identificado", etc).

---

### 🔗 Links Úteis

* **Documentação API (Swagger):** [Tripee Api Docs](https://tripee-interview.azurewebsites.net/v1/docs)

---

### Developed by Gabriel Morais Marcondes