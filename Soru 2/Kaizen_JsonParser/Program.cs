using Newtonsoft.Json;

namespace Kaizen_JsonParser
{
    // Modellerimiz

    //koordinatların olduğu model. x ve y  olarak sıraladık.
    public class Coordinates
    {
        public int x { get; set; }
        public int y { get; set; }
    }
    //açıklama ve koordinatların olduğu modelimiz.
    public class Result
    {
        public string description { get; set; }
        public Coordinates coordinates { get; set; }
    }

    //Birden fazla değer olması ihtimaline karşı dizi şeklinde model oluşturulmuştur.
    //(Case içerisinde bu durum belirtilmediği için önlem olarak yapılmıştır. Olası birden fazla fişin tek bir json içerisinde aktarılmasına karşın.)
    public class Root
    {
        public List<Result> results { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // json dosyalarının bulunduğu dizini alıyoruz. (Data klasöründen okuyacaktır.)
            string jsonDirectoryPath = "Data";

            // dizindeki tüm json dosyalarını listeliyoruz.
            string[] jsonFiles = Directory.GetFiles(jsonDirectoryPath, "*.json");


            // Her bir json dosyasını okuyoruz.
            foreach (string jsonFilePath in jsonFiles)
            {
                try
                {
                    Console.WriteLine($"Dosya okunuyor: {jsonFilePath}");

                    // json dosyası okunuyor.
                    string jsonString = File.ReadAllText(jsonFilePath);

                    // json verisini C# nesnelerine dönüştürüyoruz.
                    Root parsedData = JsonConvert.DeserializeObject<Root>(jsonString);

                    // Parse edilen veriyi fonsiyonumuzla işliyoruz.
                    ProcessParsedData(parsedData);
                }
                catch (Exception ex)
                {
                    //hata oluştuğundaki mesajımız.
                    Console.WriteLine($"İşlem gören dosyada hata! -> {jsonFilePath}: {ex.Message}");
                }
            }
        }

        static void ProcessParsedData(Root parsedData)
        {
            // koordinatlara göre sıralama yapıyoruz. (önce y koordinatına, sonra x koordinatına göre)
            // (Order By ile sıralanmış veriyi ThenBy ile tekrar sıralayabiliyoruz.)
            var sortedResults = parsedData.results
                                          .OrderBy(r => r.coordinates.y)
                                          .ThenBy(r => r.coordinates.x)
                                          .ToList();

            // sıralanan metinleri yazdırıyoruz.
            foreach (var result in sortedResults)
            {
                Console.WriteLine(result.description);
            }
            //her bir json dosyasından sonra ekrana yazılan metin
            Console.WriteLine("------------------------------------------------");
        }
    }
}