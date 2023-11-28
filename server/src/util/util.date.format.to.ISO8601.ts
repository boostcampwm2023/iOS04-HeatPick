export const dateFormatToISO8601 = (isoString: string) => {
  return new Date(isoString);
};

export const removeMillisecondsFromISOString = (isoString: string) => {
  // ISO 형식의 문자열에서 밀리초를 제외한 부분 추출
  return isoString.replace(/\.\d+Z$/, 'Z');
};