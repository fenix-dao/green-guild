export function convertArrayToObject(array) {
  const result = {};
  array.forEach((item) => {
      // Assuming the first element of each sub-array is the key
      const key = item[0];
      // And the second element is the value object
      const value = item[1];
      // If the value is an object with a single key (like Nat or Text), use that key's value
      if (typeof value === 'object' && value !== null && !Array.isArray(value)) {
          const innerKey = Object.keys(value)[0];
          result[key] = value[innerKey];
      } else {
          result[key] = value;
      }
  });
  return result;
}
export function convertTokenValueToNumber(bigIntValue) {
  const divisor = 10 ** 8;
  return Number(bigIntValue) / divisor;
}