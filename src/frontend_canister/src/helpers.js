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
export function copyToClipboard(dataValue) {
  const fallbackValue = window.location.href;
  const valueToCopy = dataValue || fallbackValue;

  // Create a new textarea element and give it the value to copy
  const textarea = document.createElement('textarea');
  textarea.value = valueToCopy;
  document.body.appendChild(textarea);

  // Select the textarea's contents
  textarea.select();

  try {
    // Copy the contents
    document.execCommand('copy');
  } catch (err) {
    console.error('Unable to copy', err);
  }

  // Clean up: remove the textarea
  document.body.removeChild(textarea);
}