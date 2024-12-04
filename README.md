# Ninety Degree


### Atalhos de teclado:
- Esc: para pausar
- c: para ativar o menu de cheats (principalmente para debug)

### Principais facilidades na UI da Godot para Debug (Variáveis Exportadas):
- Nó do Game (game.tscn):
  - Show FPS: para ativar ou não o mostrador de FPS 
  - Spawn Random Powerup: Para spawnar um power-up aleatório em uma posição aleatória do mapa
  - Not Spawn Powerup: Para bloquear o spawn de power-ups
  - Lock Difficulty: Para definir uma dificuldade específica e testa-lá/modificála individualmente
  - Not Spawn Enemy: Para bloquear o spawn de inimigos (sobrescrevendo as regras definidas pela dificuldade)

- Nó do Player (player.tscn):
  - Imortal: Impede que o personagem morra (de todas as formas)
  - No Scale Up: Impede que o personagem aumente de tamanho de acordo com o tempo
 
### Hierarquia de Pastas:
- addons: Pasta padrão de addons instalados pela asset library
- Assets: Onde está organizada todos os assets do jogo (imagens, sons, fontes, ...)
- Data: Onde estão localizados os Resources que servem de persistência de dados e/ou estratégias do StrategyPattern
- Prefabs: Onde estão todas as scenes reutilizáveis do jogo
- Scenes: Onde estão as scenes que de fato representam outras telas/visões do jogo (como os menus, ou o prórprio jogo)
- Scripts: Onde estão divididos todos os scripts que pertencem a qualquer um dos nós/scenes do jogo

### Nomenclatura Específica:
- */Characters: Representa a pasta de todos os nós do tipo CharacterBody2D que herdam da classe BaseCharacter (Player, BaseEnemy e filhos, Food)
  - ./Collisions: Utilitário criado para encapsular as lógicas do CollisionShape2D e CollisionPolygon2D, usado para criar uma margem de segurança do tamanho do BaseCharacter com base no tamanho de sua forma de colisão
- */Utils: Representa a pasta das classes utilitárias do jogo (classes helpers e/ou reutilizáveis)
  - ./Bounds: Utilitários criados para serem usados junto ou não com os CollisionGeometry (/Characters/Collisions), a fim de definir a margem de segurança para as bordas da tela (margem de segurança para impedir que os Characters ultrapassem os limites do viewport)

### Descrição das Dificuldades (A progressão dos inimigos segue o jogo original):
- Very Easy: Comida sem movimento, indo até o score = 3
- Easy: Comida em movimento horizontal, indo até o score = 8
- Medium: Comida em movimento horizontal com acréscimoo de 90% da velocidade base, aumento de 10% na velocidade do jogo, indo até o score = 20
- Hard: Comida em movimento em volta das bordas com acréscimoo de 130% da velocidade base, aumento de 15% na velocidade do jogo, indo até o score = 35
- Very Hard: Comida em movimento em forma de infinito (oito deitato) com acréscimoo de 150% da velocidade base, aumento de 20% na velocidade do jogo, indo até o score = 55
- Extreme: Comida em movimento em forma de ampulheta com acréscimoo de 200% da velocidade base, aumento de 30% na velocidade do jogo, sem limite de score
