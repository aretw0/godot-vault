# 🎮 Godot Vault

> Uma sandbox para experimentação com Godot, componentes reutilizáveis e boas práticas

## 📖 Sobre o Projeto

**Godot Vault** é acima de tudo sobre a jornada de estudar jogos, reuso de código e construção de pilares que outros projetos irão utilizar. É um espaço para amadurecer o conhecimento sobre Godot em um local centralizado, servindo como uma sandbox para experimentação.

### Objetivos

- 🎯 **Reuso de Código**: Construir componentes modulares e reutilizáveis
- 🏗️ **Arquitetura Sólida**: Estabelecer pilares arquiteturais para outros projetos
- 📚 **Aprendizado**: Documentar e compartilhar conhecimento sobre Godot
- 🧪 **Experimentação**: Espaço seguro para testar ideias e abordagens
- ✨ **Boas Práticas**: Amadurecer padrões e convenções de desenvolvimento

## 🗂️ Estrutura do Projeto

```
godot-vault/
├── core/                    # Sistemas centrais reutilizáveis
│   ├── autoload/           # Singletons globais (EventBus, GameManager)
│   ├── state_machine/      # Sistema de máquina de estados
│   ├── events/             # Sistema de eventos personalizados
│   └── utils/              # Funções utilitárias
├── components/             # Componentes composáveis de jogos
│   ├── player/            # Componentes de jogador
│   ├── camera/            # Sistemas de câmera
│   └── ui/                # Componentes de interface
├── examples/              # Cenas de demonstração
│   └── scenes/           # Exemplos de uso
├── addons/               # Plugins e ferramentas do Godot
└── docs/                 # Documentação adicional
```

## 🚀 Sistemas Principais

### EventBus (Barramento de Eventos)
Sistema global de comunicação por eventos que permite desacoplamento entre sistemas.

```gdscript
# Emitir um evento
EventBus.emit("player_died", {"score": 100})

# Escutar um evento
EventBus.on("player_died", _on_player_died)

func _on_player_died(data: Dictionary) -> void:
    print("Player morreu com score: ", data.score)
```

### StateMachine (Máquina de Estados)
Implementação genérica de máquina de estados reutilizável para IA, controles de jogador, fluxos de UI, etc.

```gdscript
var state_machine = StateMachine.new()
state_machine.add_state("idle", idle_state)
state_machine.add_state("walk", walk_state)
state_machine.set_initial_state("idle")
state_machine.transition_to("walk")
```

### GameManager (Gerenciador de Jogo)
Gerencia estado global do jogo e operações comuns.

```gdscript
GameManager.pause_game()
GameManager.resume_game()
GameManager.load_scene("res://levels/level_1.tscn")
```

### GameUtils (Utilitários)
Coleção de funções úteis para operações comuns.

```gdscript
var smoothed = GameUtils.smooth_lerp(current, target, speed, delta)
var time_str = GameUtils.seconds_to_time_string(elapsed_time)
var random_pos = GameUtils.random_point_in_circle(100.0)
```

## 🎯 Como Usar

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/aretw0/godot-vault.git
   ```

2. **Abra no Godot**: 
   - Abra o Godot Engine (versão 4.3+)
   - Importe o projeto apontando para a pasta clonada

3. **Explore os Exemplos**:
   - Execute a cena principal em `examples/main.tscn`
   - Navegue pelos sistemas em `core/`
   - Veja exemplos de uso em `examples/scenes/`

4. **Crie Seus Componentes**:
   - Adicione novos componentes em `components/`
   - Estenda os sistemas existentes
   - Documente suas criações

## 📚 Documentação

Para informações mais detalhadas:
- [Arquitetura](docs/ARCHITECTURE.md) - Visão geral da arquitetura
- [Guia de Estilo](docs/STYLE_GUIDE.md) - Convenções de código
- [Contribuindo](docs/CONTRIBUTING.md) - Como contribuir
- [Planejamento](docs/PLANNING.md) - Roadmap e fases do projeto
- [Decisões](docs/DECISIONS.md) - Decisões arquiteturais (ADRs)
- [Base de Conhecimento](docs/knowledge/README.md) - Pesquisas e aprendizados
- [CI/CD](docs/CI_CD.md) - Integração contínua e testes

## 🛠️ Requisitos

- Godot Engine 4.3 ou superior
- Conhecimento básico de GDScript

## 🤝 Contribuindo

Contribuições são bem-vindas! Este é um projeto de aprendizado e experimentação.

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🌟 Filosofia

> "A melhor maneira de aprender é construindo. O Godot Vault é um espaço para construir, experimentar, falhar e aprender."

---

**Happy Coding! 🎮✨**