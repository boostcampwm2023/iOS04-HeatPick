export const getTemperatureFeeling = (temperature: number) => {
  if (temperature >= 0 && temperature <= 15) {
    return '🧊 차가워요';
  } else if (temperature >= 16 && temperature <= 30) {
    return '🔥 조금 따뜻해요';
  } else if (temperature >= 31 && temperature <= 70) {
    return '🔥🔥 따뜻해요';
  } else if (temperature >= 71 && temperature <= 100) {
    return '🔥🔥🔥 따뜻해요';
  } else {
    return '온도 범위를 벗어났어요';
  }
};
