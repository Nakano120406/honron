# 序章
## 背景と目的
ユーザーがネットワーク通信品質を調べるために，一般に Web ベースのスピードテストサイトが用いられる．このようなサイトは多数運用されており，計測結果を統計情報の掲載やインターネットの通信品質の分析などに活用されている．しかし，通信品質において，アクセス網の種類やインターネット接続方式などのアクセス環境が通信品質にどのように影響を与えるかについては，詳細な情報が提供されていない．
本研究では，アクセス環境による通信品質の影響を明らかにするために，アクセス環境による通信品質の違いを調査し，IPv4 と IPv6 の比較の観点から分析する．それにより，アクセス環境の違いによる分析の意義を示す．また，通信品質の違いを可視化するシステムを開発し，アクセス環境による通信品質の違いをユーザーに直感的に理解できるようにする．
## 本論文の構成

# 関連研究
## スピードテストサイト

## Network Information API

# アクセス環境の影響の調査
## 調査方法
- 本研究ではアクセス環境として以下のように分類をして，それぞれ調査する．
  - インターネットサービスプロバイダの網
    - IPv4/IPv6で同じ場合
    - IPv4/IPv6で異なる場合
  - アクセス網の種類
    - FTTH
    - CATV
    - Mobile
  - インターネット接続方式
    - IPv4/IPv6共にIPoE
    - IPv4/IPv6共にPPPoE
    - IPv4がPPPoE，IPv6がIPoE
- 調査にはiNoniusスピードテストの計測ログを用いる．
  - 計測ログには，計測日時，ISP，スループット，RTT，MSS などの情報が含まれている．

| 項目           | 説明                                 |
| -------------- | ------------------------------------ |
| timestamp      | 計測が行われた日時                   |
| ip             | 計測元のIPアドレス                   |
| ispInfo        | ISPに関する情報(社名，本拠地など)    |
| ua             | 計測端末のOSやブラウザの情報         |
| connectionType | Network Information APIの結果        |
| lang           | ブラウザの言語設定                   |
| dl             | ダウロードのスループットの計測結果   |
| ul             | アップロードのスループットの計測結果 |
| ping           | RTTの計測結果                        |
| jitter         | RTTの揺らぎの計測結果                |
| mss            | MSSのサイズ                          |
| ttl            | TTLの値                              |
| lossRate       | パケットロス率の計測結果             |
| defaultIp      | デフォルトのIP                       |
| srcPort        | 計測元のソースポート                 |

  - 分析の対象としたデータの計測期間は 2022 年 10 月 1 日〜 2023 年 5 月 31 日と 2023 年 6 月 1 日 〜 2024 年 6 月 31 日のログを使用した．
  - このうち，IPv4/IPv6 デュアルスタック環境におけるアップロードとダウンロードのスループットと RTT のデータを使用する．
  - ISP の判定には計測ログに含まれる `ispInfo` の情報を用いて，ISP の判定を行った．
    - iNonius スピードテスト内で計測を行うLibrespeed がipinfo.ioに問い合わせた結果である．
  - アクセス網は計測ログだけでは判定できないため， GeoLocation Technology が提供する「どこどこ JP」を使用した．
  - インターネット接続方式の判定には，計測ログに含まれる MSS の値を用いて，先行研究と同様に表のように判定した．

| IPv4 接続方式 | IPv6 接続方式 | IPv4 MSS | IPv6 MSS |
| ------------ | ------------ | -------- | -------- |
| IPoE         | IPoE         | 1460     | 1440     |
| PPPoE        | PPPoE        | 1452     | 1394     |
| PPPoE        | IPoE         | 1452     | 1440     |

## スループットへの影響
### アクセス網によるスループットへの影響
次にアクセス網の種類によるスループットへの影響について述べる．\cref{fig:old_Line_dl,fig:new_Line_dl}はダウンロードのスループットのグラフ，\ref{fig:old_Line_ul,fig:new_Line_ul}はアップロードのスループットのグラフである．\cref{old_FTTH_dl,new_FTTH_dl}はそれぞれの期間でFTTHを使用した場合のダウンロードのスループットである．両者とも100Mbps付近にピークが表れて緩やかにデータ数が減っていくふるまいを見せている．これはアップロードの場合も類似する振る舞いをしている．一方，\cref{old_CATV_dl,new_CATV_dl}のCATVを使用した場合はピークが表れる位置がFTTHと異なり，ダウンロードの場合は340Mbps付近に表れる．アップロードの場合は10Mbpsにピークが表れている．CATVを使用したインターネット接続サービスについて調査すると，ダウンロードのスループットが最大340Mbps，アップロードのスループットが最大10Mbpsであると述べているサービスがいくつか確認された．このことからアクセス網の種類によってスループットの限界が異なることがわかる．さらに\cref{new_Mobile_dl,new_Mobile_ul}のMobileの場合は10Mbps付近にピークが表れている．Mobileを使用した場合のスループットの限界はFTTHやCATVに比べて低いことがわかる．ただし，\cref{old_CATV_dl,new_CATV_dl}を比較すると，340Mbpsのピークの前後の振る舞いが異なる．ピークの前後のデータの割合は表のように変化し340Mbps以上のデータが約20%増加している．CATVによる配信サービスについて調べると，旧来使用されてきたHFC(Hybrid Fiber-Coaxial)方式や同軸方式を光ファイバーに置き換える動きが進んでおり，総務省の資料によると約80%の事業者がFTTH方式を採用していることがわかった．このことから，アクセス網の種類だけでなくアクセス環境全体が時期によって変化していることがわかる．
以上のことからアクセス網の種類によってスループットの限界が異なることがわかったが，その振る舞いは時期によって異なることがわかった．


| 期間 | 340Mbps未満のデータの割合 | 340Mbps以上のデータの割合 |
| ---- | ------------------------- | ------------------------- |
| (1)  | 77.11%                    | 22.89%                    |
| (2)  | 57.84%                    | 42.16%                    |

### インターネット接続方式によるスループットへの影響
次にインターネット接続方式によるスループットへの影響について述べる．
- IPv4/IPoEともに

## RTTへの影響


# 可視化システム
## システム概要
## システムの開発
## システムの評価

# まとめ
## まとめ
## 今後の展望


# 使えそうな分
- アクセス環境によって通信品質に影響を与える場合，スピードテストサイトの計測ログを使用して通信品質の調査を行うときに切り分けを行わなければならない．しかし，アクセス環境が通信品質にどのように影響を与えるかについて，詳細な情報が提供されていない．そこでアクセス環境による通信品質 (スループット，RTT) への影響を，IPv4 と IPv6 の比較の観点から分析する．

## 図の挿入分
``` latex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\subsection{アクセス網の種類によるスループットへの影響}

\begin{figure}[htb]
    \begin{center}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_FTTH_dl.png}
            \subcaption{FTTHを使用した場合}
            \label{old_FTTH_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_CATV_dl.png}
            \subcaption{CATVを使用した場合}
            \label{old_CATV_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_Mobile_dl.png}
            \subcaption{Mobileを使用した場合}
            \label{old_Mobile_dl}
        \end{subfigure}
    \caption{(1)のダウンロードのスループット}
    \label{fig:old_Line_dl}

        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_FTTH_dl.png}
            \subcaption{FTTHを使用した場合}
            \label{new_FTTH_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_CATV_dl.png}
            \subcaption{CATVを使用した場合}
            \label{new_CATV_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_Mobile_dl.png}
            \subcaption{Mobileを使用した場合}
            \label{new_Mobile_dl}
        \end{subfigure}
    \caption{(2)のダウンロードのスループット}
    \label{fig:new_Line_dl}
    \end{center}
\end{figure}

\begin{figure}[htb]
    \begin{center}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_FTTH_ul.png}
            \subcaption{FTTHを使用した場合}
            \label{old_FTTH_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_CATV_ul.png}
            \subcaption{CATVを使用した場合}
            \label{old_CATV_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_Mobile_ul.png}
            \subcaption{Mobileを使用した場合}
            \label{old_Mobile_ul}
        \end{subfigure}
    \caption{(1)のアップロードのスループット}
    \label{fig:old_Line_ul}
    \end{center}
\end{figure}

\begin{figure}[htb]
    \begin{center}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_FTTH_ul.png}
            \subcaption{FTTHを使用した場合}
            \label{new_FTTH_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_CATV_ul.png}
            \subcaption{CATVを使用した場合}
            \label{new_CATV_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_Mobile_ul.png}
            \subcaption{Mobileを使用した場合}
            \label{new_Mobile_ul}
        \end{subfigure}
    \caption{(2)のアップロードのスループット}
    \label{fig:new_Line_ul}
    \end{center}
\end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\subsection{インターネット接続方式によるスループットへの影響}

\begin{figure}[htb]
    \begin{center}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_IPv4aaS_dl.png}
            \subcaption{IPv4aaSを使用した場合}
            \label{old_IPv4aaS_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_mix_dl.png}
            \subcaption{mixを使用した場合}
            \label{old_mix_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_PPPoE_dl.png}
            \subcaption{PPPoEを使用した場合}
            \label{old_PPPoE_dl}
        \end{subfigure}
    \caption{(1)のダウンロードのスループット}
    \label{fig:old_Line_dl}

        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_IPv4aaS_dl.png}
            \subcaption{IPv4aaSを使用した場合}
            \label{new_IPv4aaS_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_mix_dl.png}
            \subcaption{mixを使用した場合}
            \label{new_mix_dl}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_PPPoE_dl.png}
            \subcaption{PPPoEを使用した場合}
            \label{new_PPPoE_dl}
        \end{subfigure}
    \caption{(2)のダウンロードのスループット}
    \label{fig:new_Line_dl}
    \end{center}
\end{figure}

\begin{figure}[htb]
    \begin{center}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_IPv4aaS_ul.png}
            \subcaption{IPv4aaSを使用した場合}
            \label{old_IPv4aaS_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_mix_ul.png}
            \subcaption{mixを使用した場合}
            \label{old_mix_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/old_PPPoE_ul.png}
            \subcaption{PPPoEを使用した場合}
            \label{old_PPPoE_ul}
        \end{subfigure}
    \caption{(1)のアップロードのスループット}
    \label{fig:old_Line_ul}

        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_IPv4aaS_ul.png}
            \subcaption{IPv4aaSを使用した場合}
            \label{new_IPv4aaS_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_mix_ul.png}
            \subcaption{mixを使用した場合}
            \label{new_mix_ul}
        \end{subfigure}
        \begin{subfigure}[b]{1.0\textwidth}
            \centering
            \includegraphics[width=0.4\textwidth]{fig/new_PPPoE_ul.png}
            \subcaption{PPPoEを使用した場合}
            \label{new_PPPoE_ul}
        \end{subfigure}
    \caption{(2)のアップロードのスループット}
    \label{fig:new_Line_ul}
    \end{center}
\end{figure}
```