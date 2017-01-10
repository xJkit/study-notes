# 影像壓縮

1. Predict Coding (DPCM)
  *
2. Transform Coding (DCT)
  * 先映射，再量化
3. MPEG-1
  * units: Sequence, GOP, Picture, Macro-block, Pixel, ...
  * RGC -> YUV 根據人類的敏感度來決定壓縮方式
  1. Motion estimation -> Intra-mode -> DCT -> quantize ->
  2. Motion estimation -> Motion Vector -> DCT -> quantize ->
  3. IPB Structure:
    * I-frame
    * P/B frame

    > GOP 根據影像動態的程度可決定其大小

    > GOP 的開頭必為 I frame, 結尾可為 I 或 P frame

4. 結論
  * DCT 座標空間轉換
  * Quantization
  * Motion Compensation w/ Macro Block
  * Zig-Zag 資料壓縮與傳輸

4. H.264
  * 先前的壓縮方式只能參考前後, H.264 最多可參考到 31 張
  * 先前只有 16*16 MB, H.264可以根據影像複雜度動態決定 MB 大小
  * 利用內差可決定到 1/4 pixel 的移動向量
  * 多了 Intra prediction (幀內預測, 畫面的空間預測)
