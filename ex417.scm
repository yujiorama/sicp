
(lambda <vars>
  (define u <e1>)
  (define v <e2>)
  <e3>)

;; 本文中の式 e3 を評価する時、定義を逐次的に解釈する環境がどう構造化されるか、定義を掃き出した場合にどう構造化されるか、実際の環境の図を描く
;; 元の式
;;   https://cacoo.com/diagrams/N4vULhWrI9BLeKqh-BA6C0.png
;; 内部定義を掃き出した式
;;   https://cacoo.com/diagrams/3dr0VaDzCx2I1K9d-BA6C0.png

;; 変換したプログラムに余計なフレームがあるのはなぜか
;;   評価される環境に束縛されるものだった define を、let による束縛と set! による代入に変更したから
;;   let は lambda のシンタックスシュガーだから

;; 環境構造の違いが正しいプログラムの行動に違いを生じないのはなぜか
;;   どちらにしても e3 の評価される環境に u と v の束縛が存在しているから

;; 余計なフレームを構成せずに解釈系が内部定義の「同時」有効範囲規則を実装する方法を設計せよ
;;   わからない...
