using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace OLX.API.Helpers.CustomJsonConverters
{
    public class FlexibleDateTimeConverter : JsonConverter<DateTime>
    {
        private readonly string[] supportedFormats =
        [
             // ISO-формати
            "yyyy-MM-ddTHH:mm:ss.fffZ",
            "yyyy-MM-ddTHH:mm:ss",
            "yyyy-MM-ddTHH.mm.ss",
            "yyyy-MM-ddTHH:mm:ss.fff", // З мілісекундами
            "yyyy-MM-ddTHH:mm:ssZ",    // ISO з часовою зоною (UTC)

            // Європейські формати
            "dd.MM.yyyyTHH:mm:ss.fffZ",
            "dd.MM.yyyyTHH.mm.ss",
            "dd.MM.yyyyTHH:mm:ss",
            "dd.MM.yyyy HH.mm.ss",

            // Американські формати
            "MM/dd/yyyyTHH:mm:ss",
            "MM/dd/yyyyTHH.mm.ss",
            "MM/dd/yyyy HH:mm:ss",
            "MM/dd/yyyy HH.mm.ss",

            // Британські формати
            "dd/MM/yyyyTHH:mm:ss",
            "dd/MM/yyyyTHH.mm.ss",
            "dd/MM/yyyy HH:mm:ss",
            "dd/MM/yyyy HH.mm.ss",

            // Тільки дата
            "yyyy-MM-dd",
            "dd.MM.yyyy",
            "MM/dd/yyyy",
            "dd/MM/yyyy",

            // Тільки час
            "HH:mm:ss",
            "HH:mm:ss.fff", // Час з мілісекундами
            "HH:mm",

            // Інші можливі варіанти з часовою зоною
            "yyyy-MM-dd HH:mm:ssZ",     // Дата і час з часовою зоною
            "yyyy-MM-ddTHH:mm:sszzz",   // ISO з часовою зоною
            "dd.MM.yyyyTHH:mm:sszzz",   // Європейський формат з часовою зоною
            "MM/dd/yyyyTHH:mm:sszzz",   // Американський формат з часовою зоною
            "dd/MM/yyyyTHH:mm:sszzz"    // Британський формат з часовою зоною
        ];

        public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            if (reader.TokenType == JsonTokenType.String)
            {
                var stringValue = reader.GetString();
                if (DateTime.TryParse(stringValue, CultureInfo.InvariantCulture, DateTimeStyles.None, out var fallbackResult))
                {
                    return fallbackResult;
                }
                foreach (var format in supportedFormats)
                {
                    if (DateTime.TryParseExact(stringValue, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out var result))
                    {
                        return result;
                    }
                }
                throw new JsonException($"Invalid DateTime format: {stringValue}");
            }
            throw new JsonException("Expected a string for DateTime.");
        }

        public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(supportedFormats[0], CultureInfo.InvariantCulture));
        }
    }
}
