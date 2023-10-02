import 'package:documentation/model/schema_item.dart';
import 'package:documentation/model/schema_item_category.dart';
import 'package:documentation/model/schema_item_property.dart';

final List<SchemaItem> kSchemaItems = [
  SchemaItem(
    title: 'Отправка СМС на оплату по nonbId',
    description:
        '''Если в dto переданы данные плательщика (personId и versionId), они обновляются
Если данные плательщика не переданы, идет попытка обновить плательщика по покупателю в сделке (для неипотеки).
Если статус платежа OFFERED, меняется на NOT_PAID.
Синхронисируется с данными из Pay.
Отправляется смс (при необходимости создается платеж в Pay).''',
    categories: const [
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController'),
      SchemaItemCategory(title: 'Этап заявки', name: 'DRAFT'),
      SchemaItemCategory(title: 'Этап заявки', name: 'SERVICES_PAYMENT'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.sendSmsByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/sms'),
      SchemaItemProperty(
          title: 'Возвращает',
          value:
              'успешность выполнения, телефон (при успешном выполнении), время, через которое можно снова пробовать отправить с секундах'),
    ],
  ),
  SchemaItem(
    title: 'Скачивание квитанции на оплату',
    description: '''Если статус платежа OFFERED, меняется на NOT_PAID.
Синхронисируется с данными из Pay.
Получает из Pay квитанцию об оплате (при необходимости создается платеж в Pay).''',
    categories: const [
      SchemaItemCategory(title: 'Cервис КУ', name: 'Document'),
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController'),
      SchemaItemCategory(title: 'Этап заявки', name: 'SIGNING_OFFER'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.generateReceiptByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/receipt'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'массив байт файла квитанции'),
    ],
  ),
  SchemaItem(
    title: 'Регистрация платежа в Pay',
    description:
        '''Создает платеж в Pay. Если платеж уже создан, возвращает его идентификатор.''',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.registerPaymentInPay'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/pay/payment'),
      SchemaItemProperty(title: 'Возвращает', value: 'Идентифиактор в Pay'),
    ],
  ),
  SchemaItem(
    title: 'Получение данных по платежам',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbId'),
      SchemaItemProperty(title: 'Http-путь', value: '/deals/{nonbId}/payments'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список платежей по nonbId'),
    ],
  ),
  SchemaItem(
    title: 'Получение данных по активным платежам',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Validator'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/active'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список сокращенных данных по платежам'),
    ],
  ),
  SchemaItem(
    title: 'Наличие согласия на пакет',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.checkHasPackageByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/has-package'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'true, если в сделке есть платеж с типом PACKAGE, иначе возвращает false.'),
    ],
  ),
  SchemaItem(
    title: 'Пересчет номеров оферт СЭР и СБР',
    description: "Генерируются / пересчитываются номера (записываются в БД).",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'NumberOfferService.recalculateByNonbDealIds'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/payments/number/recalculate'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список типов платежей (для каждого из переданных nonbId) и соотвествующие им номера.'),
    ],
  ),
  SchemaItem(
    title: 'Получение детальной информации по платежу',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PriceService.getPaymentDetails'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Разбивку цены платежа по составляющим'),
    ],
  ),
  SchemaItem(
    title: 'Сброс плательщика',
    description: "Для платежей с переданными идентификаторами сбрасываются значения полей nonbParticipantId, personId, versionId",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.resetPayer'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/reset/payers/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
  SchemaItem(
    title: 'Установка типа оплаты и плательщика',
    description: "Устанавливает для платежа значения полей payType, nonbParticipantId, personId, versionId",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentDataPreparerService.patchPayerAndPayType'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/pay/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
  SchemaItem(
    title: 'Получение платежей по nonbId и списку услуг',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Notification-center'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbIdAndServices'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/active/services'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список упрощенных платежей по переданным типам услуг и nonbId'),
    ],
  ),
  SchemaItem(
    title: 'Регистрация платежей в Pay',
    description: "Создает платеж в Pay (если не создан). Устанавливает для платежа payIdentifier.",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PayService.registerPaymentsByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/register/pay/payments'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности регистрации по каждому из платежей'),
    ],
  ),
  SchemaItem(
    title: 'Оформление заявки на возврат',
    description: 'Обновляет данные плательщика. Изменяет статус платежа на PREREFUND. Создает / актуализирует в сервисе refund заявку на возврат (отправляет смс). Проставляет статус WAITING_FOR_REFUND_APPLICATION в sh.',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.requestRefund'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности оформления завки. В случае успеха, возвращает телефон, на который отправленна ссылка для заявки'),
    ],
  ),
  SchemaItem(
    title: 'Получение списка причин для возврата ДС',
    description: '',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.getRefundReasons'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/{nonbId}/payments/{paymentId}/refund/reasons'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список причин для возврада по услуге ДКП'),
    ],
  ),
  SchemaItem(
    title: 'Скачивание соглашения',
    description: '',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.downloadAgreementByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund/agreement'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Массив байт. Соглашение на возврат.'),
    ],
  ),
  SchemaItem(
    title: 'Отправка смс клиенту на возврат',
    description: 'Создает / актуализирует в сервисе refund заявку на возврат (отправляет смс).',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.sendSmsByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund/sms'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности отправки смс. В случае успеха, возвращает телефон, на который отправленна ссылка для заявки'),
    ],
  ),
  SchemaItem(
    title: 'Отмена заявки на возврат',
    description: 'Меняет статус платежа на PAID. Меняет статус заявки на возврат на CANCELLED.',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PUT'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.cancelRefundByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/{nonbId}/payments/{paymentId}/refund/cancel'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
];

final List<SchemaItem> kSchemaItems1 = [
  SchemaItem(
    title: 'Отправка СМС на оплату по nonbId',
    description:
    '''Если в dto переданы данные плательщика (personId и versionId), они обновляются
Если данные плательщика не переданы, идет попытка обновить плательщика по покупателю в сделке (для неипотеки).
Если статус платежа OFFERED, меняется на NOT_PAID.
Синхронисируется с данными из Pay.
Отправляется смс (при необходимости создается платеж в Pay).''',
    categories: const [
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController1'),
      SchemaItemCategory(title: 'Этап заявки', name: 'DRAFT'),
      SchemaItemCategory(title: 'Этап заявки', name: 'SERVICES_PAYMENT'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.sendSmsByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/sms'),
      SchemaItemProperty(
          title: 'Возвращает',
          value:
          'успешность выполнения, телефон (при успешном выполнении), время, через которое можно снова пробовать отправить с секундах'),
    ],
  ),
  SchemaItem(
    title: 'Скачивание квитанции на оплату',
    description: '''Если статус платежа OFFERED, меняется на NOT_PAID.
Синхронисируется с данными из Pay.
Получает из Pay квитанцию об оплате (при необходимости создается платеж в Pay).''',
    categories: const [
      SchemaItemCategory(title: 'Cервис КУ', name: 'Document'),
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController2'),
      SchemaItemCategory(title: 'Этап заявки', name: 'SIGNING_OFFER'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.generateReceiptByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/receipt'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'массив байт файла квитанции'),
    ],
  ),
  SchemaItem(
    title: 'Регистрация платежа в Pay',
    description:
    '''Создает платеж в Pay. Если платеж уже создан, возвращает его идентификатор.''',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'InvoiceSrvController1'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'InvoiceService.registerPaymentInPay'),
      SchemaItemProperty(
          title: 'Http-путь',
          value: '/deals/{nonbId}/payments/{paymentId}/pay/payment'),
      SchemaItemProperty(title: 'Возвращает', value: 'Идентифиактор в Pay'),
    ],
  ),
  SchemaItem(
    title: 'Получение данных по платежам',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController2'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbId'),
      SchemaItemProperty(title: 'Http-путь', value: '/deals/{nonbId}/payments'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список платежей по nonbId'),
    ],
  ),
  SchemaItem(
    title: 'Получение данных по активным платежам',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Validator'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/active'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список сокращенных данных по платежам'),
    ],
  ),
  SchemaItem(
    title: 'Наличие согласия на пакет',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.checkHasPackageByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/has-package'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'true, если в сделке есть платеж с типом PACKAGE, иначе возвращает false.'),
    ],
  ),
  SchemaItem(
    title: 'Пересчет номеров оферт СЭР и СБР',
    description: "Генерируются / пересчитываются номера (записываются в БД).",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'NumberOfferService.recalculateByNonbDealIds'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/payments/number/recalculate'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список типов платежей (для каждого из переданных nonbId) и соотвествующие им номера.'),
    ],
  ),
  SchemaItem(
    title: 'Получение детальной информации по платежу',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PriceService.getPaymentDetails'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Разбивку цены платежа по составляющим'),
    ],
  ),
  SchemaItem(
    title: 'Сброс плательщика',
    description: "Для платежей с переданными идентификаторами сбрасываются значения полей nonbParticipantId, personId, versionId",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.resetPayer'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/reset/payers/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
  SchemaItem(
    title: 'Установка типа оплаты и плательщика',
    description: "Устанавливает для платежа значения полей payType, nonbParticipantId, personId, versionId",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PATCH'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentDataPreparerService.patchPayerAndPayType'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/pay/details'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
  SchemaItem(
    title: 'Получение платежей по nonbId и списку услуг',
    description: "",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Notification-center'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PaymentService.getPaymentsByNonbIdAndServices'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/active/services'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список упрощенных платежей по переданным типам услуг и nonbId'),
    ],
  ),
  SchemaItem(
    title: 'Регистрация платежей в Pay',
    description: "Создает платеж в Pay (если не создан). Устанавливает для платежа payIdentifier.",
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'PaymentSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Orchestrator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'PayService.registerPaymentsByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/register/pay/payments'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности регистрации по каждому из платежей'),
    ],
  ),
  SchemaItem(
    title: 'Оформление заявки на возврат',
    description: 'Обновляет данные плательщика. Изменяет статус платежа на PREREFUND. Создает / актуализирует в сервисе refund заявку на возврат (отправляет смс). Проставляет статус WAITING_FOR_REFUND_APPLICATION в sh.',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.requestRefund'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности оформления завки. В случае успеха, возвращает телефон, на который отправленна ссылка для заявки'),
    ],
  ),
  SchemaItem(
    title: 'Получение списка причин для возврата ДС',
    description: '',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.getRefundReasons'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/{nonbId}/payments/{paymentId}/refund/reasons'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Список причин для возврада по услуге ДКП'),
    ],
  ),
  SchemaItem(
    title: 'Скачивание соглашения',
    description: '',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'GET'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.downloadAgreementByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund/agreement'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Массив байт. Соглашение на возврат.'),
    ],
  ),
  SchemaItem(
    title: 'Отправка смс клиенту на возврат',
    description: 'Создает / актуализирует в сервисе refund заявку на возврат (отправляет смс).',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController2'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'POST'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.sendSmsByNonbDealId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/deals/{nonbId}/payments/{paymentId}/refund/sms'),
      SchemaItemProperty(
          title: 'Возвращает', value: 'Информацию об успешности отправки смс. В случае успеха, возвращает телефон, на который отправленна ссылка для заявки'),
    ],
  ),
  SchemaItem(
    title: 'Отмена заявки на возврат',
    description: 'Меняет статус платежа на PAID. Меняет статус заявки на возврат на CANCELLED.',
    categories: const [
      SchemaItemCategory(title: 'Контроллер', name: 'RefundSrvController1'),
      SchemaItemCategory(title: 'Cервис КУ', name: 'Mediator'),
    ],
    properties: const [
      SchemaItemProperty(title: 'Http-метод', value: 'PUT'),
      SchemaItemProperty(
          title: 'Метод обработки',
          value: 'RefundService.cancelRefundByNonbId'),
      SchemaItemProperty(
          title: 'Http-путь', value: '/{nonbId}/payments/{paymentId}/refund/cancel'),
      SchemaItemProperty(
          title: 'Возвращает', value: ''),
    ],
  ),
];
