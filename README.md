# 地震資料處理
`2022.09-2023.01`
`宜謙論文`
`檔案位置：C:\Users\傳Yee\Desktop\原始地震資料`

## PulseClassification-master
`檔案位置：C:\Users\傳Yee\Desktop\原始地震資料\PulseClassification-master`
- Baker 處理脈衝項、殘餘項、PI值計算
`PI值-energy ratio`

## 台南地震資料
`檔案位置：C:\Users\傳Yee\Desktop\原始地震資料\Tainan`
> 1. compatible_program：將原始地震資料擬合成符合設計反應譜
> 2. Tainan_original_data：台南原始資料
> 3. Tainan_distinguish_earthquake：台南地震種類判斷
> 4. Tainan_near_fault：台南具斷層效應之地震
> 5. Tainan_far_field：台南不具斷層效應之地震
> 6. Tainan_compatible_data：符合設計反應譜之地震資料
> 7. Tainan_PGA_modify：台南調整PGA後之原始地震資料

### 台南原始資料
`檔案位置：C:\Users\傳Yee\Desktop\原始地震資料\Tainan\Tainan_original_data`
- original_data：原始資料作圖(a(U)-t, a(N)-t, a(E)-t, PGA-T)
- Tainan_transfer_txt_2_mat：將原始資料儲存至 Tainan_no_NE_mat.mat
- Tainan_no_NE_mat.mat：原始資料 matlab data 格式
- Tainan_transfer_all_2_NE.mlx：將原始資料之a(N), a(E)儲存至 Tainan_NE_original.mat
- Tainan_NE_original.mat：t-a(N), t-a(E) 之原始資料

### 台南地震種類判斷
`檔案位置：C:\Users\傳Yee\Desktop\原始地震資料\Tainan\Tainan_distinguish_earthquake`
- Tainan.mat：台南原始資料
- Tainan_distinguish_earthquake.m：小波跟速度作圖，可藉由觀察是否有能量集中現象判斷近斷層效應


## 台北資料處理
``
