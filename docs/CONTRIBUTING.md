# Contribuindo para Godot Vault

Obrigado por considerar contribuir para o Godot Vault! Este é um projeto de aprendizado e experimentação, e contribuições são muito bem-vindas.

## Como Contribuir

### Reportando Bugs

Se você encontrar um bug:

1. Verifique se já não existe uma issue sobre o problema
2. Crie uma nova issue incluindo:
   - Descrição clara do problema
   - Passos para reproduzir
   - Comportamento esperado vs. observado
   - Versão do Godot
   - Sistema operacional

### Sugerindo Melhorias

Para sugerir novas funcionalidades ou melhorias:

1. Abra uma issue descrevendo:
   - O problema que a feature resolve
   - Proposta de solução
   - Exemplos de uso
   - Possíveis alternativas

### Pull Requests

1. **Fork o projeto**
   ```bash
   git clone https://github.com/seu-usuario/godot-vault.git
   ```

2. **Crie uma branch para sua feature**
   ```bash
   git checkout -b feature/minha-feature
   ```

3. **Faça suas alterações**
   - Siga o [Guia de Estilo](STYLE_GUIDE.md)
   - Mantenha commits atômicos e descritivos
   - Adicione documentação se necessário

4. **Teste suas alterações**
   - Verifique se o projeto abre sem erros no Godot
   - Teste a funcionalidade adicionada
   - Verifique se não quebrou funcionalidades existentes

5. **Commit suas mudanças**
   ```bash
   git commit -m "feat: adiciona sistema de inventory"
   ```

6. **Push para sua branch**
   ```bash
   git push origin feature/minha-feature
   ```

7. **Abra um Pull Request**
   - Descreva claramente as mudanças
   - Referencie issues relacionadas
   - Adicione screenshots se aplicável

## Convenções de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: nova funcionalidade
fix: correção de bug
docs: mudanças em documentação
style: formatação, sem mudança de código
refactor: refatoração de código
test: adição de testes
chore: tarefas de manutenção
```

Exemplos:
```
feat: adiciona componente de camera follow
fix: corrige bug no EventBus ao remover listeners
docs: atualiza README com exemplos de StateMachine
refactor: melhora performance do GameUtils
```

## Estrutura de Contribuições

### Adicionando Core Systems

Core systems são fundamentais e devem:
- Ser genéricos e reutilizáveis
- Não ter dependências de game-specific
- Estar bem documentados
- Ter exemplos de uso

Localização: `core/`

### Adicionando Components

Components devem:
- Ser modulares e composáveis
- Ter configurações via @export
- Usar core systems quando apropriado
- Incluir exemplo de uso

Localização: `components/`

### Adicionando Exemplos

Exemplos devem:
- Demonstrar uso claro de sistemas
- Ser simples e focados
- Incluir comentários explicativos

Localização: `examples/`

### Adicionando Documentação

Documentação deve:
- Ser clara e concisa
- Incluir exemplos práticos
- Estar em português (primary) ou inglês

Localização: `docs/`

## Revisão de Código

Ao revisar PRs, consideramos:

- **Qualidade do Código**: Segue guia de estilo?
- **Funcionalidade**: Funciona conforme esperado?
- **Documentação**: Está documentado adequadamente?
- **Reusabilidade**: Pode ser reutilizado?
- **Testes**: Foi testado?

## Prioridades do Projeto

Contribuições que se alinham com estas prioridades são especialmente bem-vindas:

1. **Core Systems**: Sistemas fundamentais reutilizáveis
2. **Components**: Componentes modulares de jogos
3. **Documentation**: Melhorias na documentação
4. **Examples**: Exemplos práticos de uso
5. **Tools**: Ferramentas para desenvolvimento

## Não Aceito

Por favor, evite:
- Código não documentado
- Dependências desnecessárias
- Código não testado
- Breaking changes sem discussão prévia
- Assets muito grandes sem justificativa

## Código de Conduta

### Nossa Promessa

Estamos comprometidos em tornar a participação neste projeto uma experiência livre de assédio para todos.

### Padrões

Comportamentos que contribuem para um ambiente positivo:

- Usar linguagem acolhedora e inclusiva
- Respeitar pontos de vista diferentes
- Aceitar críticas construtivas graciosamente
- Focar no que é melhor para a comunidade

Comportamentos inaceitáveis:

- Uso de linguagem ou imagens sexualizadas
- Trolling, insultos ou ataques pessoais
- Assédio público ou privado
- Publicar informações privadas de outros

### Responsabilidades

Mantenedores do projeto são responsáveis por esclarecer padrões de comportamento aceitável e tomar ação apropriada em resposta a comportamentos inaceitáveis.

## Dúvidas?

Se tiver dúvidas sobre como contribuir:

1. Abra uma issue com a tag `question`
2. Consulte a documentação existente
3. Entre em contato com os mantenedores

## Agradecimentos

Toda contribuição, grande ou pequena, é valorizada e apreciada!

Obrigado por ajudar a tornar o Godot Vault melhor! 🎮✨
