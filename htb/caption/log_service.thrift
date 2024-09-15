namespace go log_service
service LogService {
string ReadLogFile(1: string filePath)
}
